Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1703157F7F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgBJQLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 11:11:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727653AbgBJQLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 11:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581351073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NIWaVw5jhLpMWAttBHwaJeIbR+xv7livUZuR+cMhN08=;
        b=h+bk7mJ/azcIGR8L8tNW1qxAUzENTOgRD2WOIQNa4WstB/EPHuJSrt5wUVkLb4j9E1RMzv
        5DS4tpjPWRFMZenlQzwuzdyvo1qoUemEdyd7xG9qLM3uaxRzcmybimVBPbldI2K9C+aYl0
        pOyaYs2wETDVd2NKVrNhyJ7zehJFo2E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Jy1XXni2PeubZBy4hf-gvA-1; Mon, 10 Feb 2020 11:11:04 -0500
X-MC-Unique: Jy1XXni2PeubZBy4hf-gvA-1
Received: by mail-lj1-f199.google.com with SMTP id j1so2743156lja.3
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2020 08:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIWaVw5jhLpMWAttBHwaJeIbR+xv7livUZuR+cMhN08=;
        b=iI+1dqew+rlkiK+zcfgpSINVyb3uZHQKtLBV8OW5PdxQuqRuqvD9BQliaXTdqypNHT
         wFok95EmHokiFpsQTm4k66MpeddPKio17GTzcKErPw9Buk5YwYQvtmYIxRgVCCCgqYNK
         zHQLKIgKKExt5gRF2s8SnKf+kDA6gvZuaCvp++NljsbQsbw76Vsn1QvUFYpuSnz9lLm0
         E+Y8fIM41GVCKfHRvat2WfCGEIVugQ9O+xGJ9W+KCBLyiiYQnkJHlSeZI0IrMx9VFV3K
         S4jhZ4CKn1AM9kHSBM6LEF5JFsKtkUpZXWS/nbPitxx+IYhMBpcVGX/z4g9X7nppQzYw
         t88w==
X-Gm-Message-State: APjAAAUAe6hTXacCrPiQEGNw81YuuRGl5VdM8zW8sCY702x+SCl2nUp9
        E7a9wL4LJiTI8sH6ec2/ouXmxbkcgYirWnYnDkVEgJfdWq3CiYuk7IICCgaxywSjQHatpkOKp0s
        8NCIWGLVLs5OR
X-Received: by 2002:a2e:981a:: with SMTP id a26mr1424468ljj.82.1581351062970;
        Mon, 10 Feb 2020 08:11:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSSNXAHlk2ph5/QqAv1k/Z3gvdok6P4NC3RKeqoXwITQxFDJK00ShyX8fetMDqjlcg9glmBw==
X-Received: by 2002:a2e:981a:: with SMTP id a26mr1424441ljj.82.1581351062645;
        Mon, 10 Feb 2020 08:11:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y29sm513953ljd.88.2020.02.10.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 08:11:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 195A4180365; Mon, 10 Feb 2020 17:11:01 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stepan Horacek <shoracek@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] core: Don't skip generic XDP program execution for cloned SKBs
Date:   Mon, 10 Feb 2020 17:10:46 +0100
Message-Id: <20200210161046.221258-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current generic XDP handler skips execution of XDP programs entirely if
an SKB is marked as cloned. This leads to some surprising behaviour, as
packets can end up being cloned in various ways, which will make an XDP
program not see all the traffic on an interface.

This was discovered by a simple test case where an XDP program that always
returns XDP_DROP is installed on a veth device. When combining this with
the Scapy packet sniffer (which uses an AF_PACKET) socket on the sending
side, SKBs reliably end up in the cloned state, causing them to be passed
through to the receiving interface instead of being dropped. A minimal
reproducer script for this is included below.

This patch fixed the issue by simply triggering the existing linearisation
code for cloned SKBs instead of skipping the XDP program execution. This
behaviour is in line with the behaviour of the native XDP implementation
for the veth driver, which will reallocate and copy the SKB data if the SKB
is marked as shared.

Reproducer Python script (requires BCC and Scapy):

from scapy.all import TCP, IP, Ether, sendp, sniff, AsyncSniffer, Raw, UDP
from bcc import BPF
import time, sys, subprocess, shlex

SKB_MODE = (1 << 1)
DRV_MODE = (1 << 2)
PYTHON=sys.executable

def client():
    time.sleep(2)
    # Sniffing on the sender causes skb_cloned() to be set
    s = AsyncSniffer()
    s.start()

    for p in range(10):
        sendp(Ether(dst="aa:aa:aa:aa:aa:aa", src="cc:cc:cc:cc:cc:cc")/IP()/UDP()/Raw("Test"),
              verbose=False)
        time.sleep(0.1)

    s.stop()
    return 0

def server(mode):
    prog = BPF(text="int dummy_drop(struct xdp_md *ctx) {return XDP_DROP;}")
    func = prog.load_func("dummy_drop", BPF.XDP)
    prog.attach_xdp("a_to_b", func, mode)

    time.sleep(1)

    s = sniff(iface="a_to_b", count=10, timeout=15)
    if len(s):
        print(f"Got {len(s)} packets - should have gotten 0")
        return 1
    else:
        print("Got no packets - as expected")
        return 0

if len(sys.argv) < 2:
    print(f"Usage: {sys.argv[0]} <skb|drv>")
    sys.exit(1)

if sys.argv[1] == "client":
    sys.exit(client())
elif sys.argv[1] == "server":
    mode = SKB_MODE if sys.argv[2] == 'skb' else DRV_MODE
    sys.exit(server(mode))
else:
    try:
        mode = sys.argv[1]
        if mode not in ('skb', 'drv'):
            print(f"Usage: {sys.argv[0]} <skb|drv>")
            sys.exit(1)
        print(f"Running in {mode} mode")

        for cmd in [
                'ip netns add netns_a',
                'ip netns add netns_b',
                'ip -n netns_a link add a_to_b type veth peer name b_to_a netns netns_b',
                # Disable ipv6 to make sure there's no address autoconf traffic
                'ip netns exec netns_a sysctl -qw net.ipv6.conf.a_to_b.disable_ipv6=1',
                'ip netns exec netns_b sysctl -qw net.ipv6.conf.b_to_a.disable_ipv6=1',
                'ip -n netns_a link set dev a_to_b address aa:aa:aa:aa:aa:aa',
                'ip -n netns_b link set dev b_to_a address cc:cc:cc:cc:cc:cc',
                'ip -n netns_a link set dev a_to_b up',
                'ip -n netns_b link set dev b_to_a up']:
            subprocess.check_call(shlex.split(cmd))

        server = subprocess.Popen(shlex.split(f"ip netns exec netns_a {PYTHON} {sys.argv[0]} server {mode}"))
        client = subprocess.Popen(shlex.split(f"ip netns exec netns_b {PYTHON} {sys.argv[0]} client"))

        client.wait()
        server.wait()
        sys.exit(server.returncode)

    finally:
        subprocess.run(shlex.split("ip netns delete netns_a"))
        subprocess.run(shlex.split("ip netns delete netns_b"))

Fixes: d445516966dc ("net: xdp: support xdp generic on virtual devices")
Reported-by: Stepan Horacek <shoracek@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a69e8bd7ed74..a6316b336128 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4527,14 +4527,14 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	/* Reinjected packets coming from act_mirred or similar should
 	 * not get XDP generic processing.
 	 */
-	if (skb_cloned(skb) || skb_is_tc_redirected(skb))
+	if (skb_is_tc_redirected(skb))
 		return XDP_PASS;
 
 	/* XDP packets must be linear and must have sufficient headroom
 	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
 	 * native XDP provides, thus we need to do it here as well.
 	 */
-	if (skb_is_nonlinear(skb) ||
+	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
 		int troom = skb->tail + skb->data_len - skb->end;
-- 
2.25.0

