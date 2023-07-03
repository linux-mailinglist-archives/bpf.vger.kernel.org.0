Return-Path: <bpf+bounces-3889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96438746194
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 19:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0911C209ED
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8A107A8;
	Mon,  3 Jul 2023 17:52:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB410780;
	Mon,  3 Jul 2023 17:52:55 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED2E42;
	Mon,  3 Jul 2023 10:52:53 -0700 (PDT)
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B85E4240008;
	Mon,  3 Jul 2023 17:52:49 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH bpf-next] xsk: honor SO_BINDTODEVICE on bind
Date: Mon,  3 Jul 2023 19:53:29 +0200
Message-Id: <20230703175329.3259672-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
A privileged process might create the socket and pass it to a
non-privileged process for later use.  However, that process will be
able to bind the socket to any network interface.  Even though it will
not be able to receive any traffic without modification of the BPF map,
the situation is not ideal.

Sockets already have a mechanism that can be used to restrict what
interface they can be attached to.  That is SO_BINDTODEVICE.

To change the SO_BINDTODEVICE binding the process will need CAP_NET_RAW.

Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
workflow when non-privileged process is using AF_XDP.

The intended workflow is following:

  1. First process creates a bare socket with socket(AF_XDP, ...).
  2. First process loads the XSK program to the interface.
  3. First process adds the socket fd to a BPF map.
  4. First process ties socket fd to a particular interface using
     SO_BINDTODEVICE.
  5. First process sends socket fd to a second process.
  6. Second process allocates UMEM.
  7. Second process binds socket to the interface with bind(...).
  8. Second process sends/receives the traffic.

All the steps above are possible today if the first process is
privileged and the second one has sufficient RLIMIT_MEMLOCK and no
capabilities.  However, the second process will be able to bind the
socket to any interface it wants on step 7 and send traffic from it.
With the proposed change, the second process will be able to bind
the socket only to a specific interface chosen by the first process
at step 4.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

RFC --> PATCH:
  * Better explained intended workflow in a commit message.
  * Added ACK from Magnus.

 Documentation/networking/af_xdp.rst | 9 +++++++++
 net/xdp/xsk.c                       | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 247c6c4127e9..1cc35de336a4 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
 application to use. The final option is the flags field, but it will
 be dealt with in separate sections for each UMEM flag.
 
+SO_BINDTODEVICE setsockopt
+--------------------------
+
+This is a generic SOL_SOCKET option that can be used to tie AF_XDP
+socket to a particular network interface.  It is useful when a socket
+is created by a privileged process and passed to a non-privileged one.
+Once the option is set, kernel will refuse attempts to bind that socket
+to a different interface.  Updating the value requires CAP_NET_RAW.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5a8c0dd250af..386ff641db0f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct net_device *dev;
+	int bound_dev_if;
 	u32 flags, qid;
 	int err = 0;
 
@@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		      XDP_USE_NEED_WAKEUP))
 		return -EINVAL;
 
+	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+
+	if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
+		return -EINVAL;
+
 	rtnl_lock();
 	mutex_lock(&xs->mutex);
 	if (xs->state != XSK_READY) {
-- 
2.40.1


