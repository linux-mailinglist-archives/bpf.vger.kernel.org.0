Return-Path: <bpf+bounces-3865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F026A7459DD
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD5C1C2031D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58EC46A1;
	Mon,  3 Jul 2023 10:13:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802FC4416;
	Mon,  3 Jul 2023 10:13:48 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412CE5E;
	Mon,  3 Jul 2023 03:13:41 -0700 (PDT)
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
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D49061C000A;
	Mon,  3 Jul 2023 10:13:36 +0000 (UTC)
Message-ID: <c6944b25-7ac4-0b75-75b1-465c8a705d02@ovn.org>
Date: Mon, 3 Jul 2023 12:14:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC bpf-next] xsk: honor SO_BINDTODEVICE on bind
Content-Language: en-US
To: Magnus Karlsson <magnus.karlsson@gmail.com>
References: <20230630145831.2988845-1-i.maximets@ovn.org>
 <CAJ8uoz1TGjWuJKkZ8C9ZrQB0CDasik3A=qJs=xwdQP8cbn97VQ@mail.gmail.com>
 <04ed302e-067e-d372-370b-3fef1cf8c7f2@ovn.org>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <04ed302e-067e-d372-370b-3fef1cf8c7f2@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 12:06, Ilya Maximets wrote:
> On 7/3/23 11:48, Magnus Karlsson wrote:
>> On Fri, 30 Jun 2023 at 16:58, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>
>>> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
>>> A privileged process might create the socket and pass it to a
>>> non-privileged process for later use.  However, that process will be
>>> able to bind the socket to any network interface.  Even though it will
>>> not be able to receive any traffic without modification of the BPF map,
>>> the situation is not ideal.
>>>
>>> Sockets already have a mechanism that can be used to restrict what
>>> interface they can be attached to.  That is SO_BINDTODEVICE.
>>>
>>> To change the binding the process will need CAP_NET_RAW.
>>>
>>> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
>>> workflow when non-privileged process is using AF_XDP.
>>
>> Rebinding an AF_XDP socket is not allowed today. Any such attempt will
>> return an error from bind. So if I understand the purpose of
>> SO_BINDTODEVICE correctly, you could say that this option is always
>> set for an AF_XDP socket and it is not possible to toggle it. The only
>> way to "rebind" an AF_XDP socket is to close it and open a new one.
>> This was a conscious design decision from day one as it would be very
>> hard to support this, especially in zero-copy mode.
> 
> Hi, Magnus.
> 
> The purpose of this patch is not to allow re-binding.  The use case is
> following:
> 
> 1. First process creates a bare socket with socket(AF_XDP, ...).
> 2. First process loads the XSK program to the interface.
> 3. First process adds the socket fd to a BPF map.
> 4. First process sends socket fd to a second process.
> 5. Second process allocates UMEM.
> 6. Second process binds socket to the interface.

7. Second process sends/receives the traffic. :)

> 
> The idea is that the first process will call SO_BINDTODEVICE before
> sending socket fd to a second process, so the second process is limited
> in to which interface it can bind the socket.
> 
> Does that make sense?
> 
> This workflow allows the second process to have no capabilities
> as long as it has sufficient RLIMIT_MEMLOCK.

Note that steps 1-7 are working just fine today.  i.e. the umem
registration, bind, ring mapping and traffic send/receive do not
require any extra capabilities.

We may restrict the bind() call to require CAP_NET_RAW and then
allow it for sockets that had SO_BINDTODEVICE as an alternative.
But restriction will break the current uAPI.

> 
> Best regards, Ilya Maximets.
> 
>>
>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>> ---
>>>
>>> Posting as an RFC for now to probably get some feedback.
>>> Will re-post once the tree is open.
>>>
>>>  Documentation/networking/af_xdp.rst | 9 +++++++++
>>>  net/xdp/xsk.c                       | 6 ++++++
>>>  2 files changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
>>> index 247c6c4127e9..1cc35de336a4 100644
>>> --- a/Documentation/networking/af_xdp.rst
>>> +++ b/Documentation/networking/af_xdp.rst
>>> @@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N bytes for the
>>>  application to use. The final option is the flags field, but it will
>>>  be dealt with in separate sections for each UMEM flag.
>>>
>>> +SO_BINDTODEVICE setsockopt
>>> +--------------------------
>>> +
>>> +This is a generic SOL_SOCKET option that can be used to tie AF_XDP
>>> +socket to a particular network interface.  It is useful when a socket
>>> +is created by a privileged process and passed to a non-privileged one.
>>> +Once the option is set, kernel will refuse attempts to bind that socket
>>> +to a different interface.  Updating the value requires CAP_NET_RAW.
>>> +
>>>  XDP_STATISTICS getsockopt
>>>  -------------------------
>>>
>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>>> index 5a8c0dd250af..386ff641db0f 100644
>>> --- a/net/xdp/xsk.c
>>> +++ b/net/xdp/xsk.c
>>> @@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>>>         struct sock *sk = sock->sk;
>>>         struct xdp_sock *xs = xdp_sk(sk);
>>>         struct net_device *dev;
>>> +       int bound_dev_if;
>>>         u32 flags, qid;
>>>         int err = 0;
>>>
>>> @@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>>>                       XDP_USE_NEED_WAKEUP))
>>>                 return -EINVAL;
>>>
>>> +       bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
>>> +
>>> +       if (bound_dev_if && bound_dev_if != sxdp->sxdp_ifindex)
>>> +               return -EINVAL;
>>> +
>>>         rtnl_lock();
>>>         mutex_lock(&xs->mutex);
>>>         if (xs->state != XSK_READY) {
>>> --
>>> 2.40.1
>>>
>>>
> 


