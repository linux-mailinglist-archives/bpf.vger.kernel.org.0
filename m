Return-Path: <bpf+bounces-6842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7E76E898
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E5F282153
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21DD1ED4C;
	Thu,  3 Aug 2023 12:42:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F31DDC2
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 12:42:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3135A4
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691066553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfTmYD28gRUQxEv/F82rqwXCUGgxTUb21DSPMY1yz5o=;
	b=ORqsgGKBm4AF3SN3D9xTD0z+k4HZ3iHXS81a09mEKPm2zvu3PvtUWgefr88C6pXckLc2I6
	P7of2vgOlBtVlzPwrNC67asXelL08uCZxbJmmA8qZRNVzYLEvyKFCHi0jhGRPgW9jhLYT8
	BZjRAxU7zR5+8wmF7vCdCSrFMoarXTM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-CrazcLH1OKezYXf8B4cxpg-1; Thu, 03 Aug 2023 08:42:32 -0400
X-MC-Unique: CrazcLH1OKezYXf8B4cxpg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe27502459so1178822e87.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 05:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066551; x=1691671351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfTmYD28gRUQxEv/F82rqwXCUGgxTUb21DSPMY1yz5o=;
        b=J80jXuvnWNMB85b1/QStDQa9pVC0oSFqwNR6ELGWXbbJvtxMS+nvBoizlZso3aWC71
         +v+ilXbycufpj3pxqW18+etKZ7GauWI/L8QEhAzIojBaeasraegDj94MWgw7FgOirZS1
         2InHZO0CfURzJCMEyIfd87BkAusrwUONf2OMnBsYCIw4QqThB7mWiuGWl1qEBuhkJ2cU
         Bl+ljqjgNiR1jifYvnB/WxBdDbUyySWEVFXf01ccIJnV90pgqrF/XjN1rBqoYVYIAhpl
         LcXAgqOcnaBr+FdQJ9jWCfMoBMcRNV4v45BEBirAU9yyjoS05nU5RzJCtuOCarApdUTV
         6n/A==
X-Gm-Message-State: ABy/qLZsQAn9+lCVuu4zgIcXbHIyKfc/j1RUR48/PvUo48o6RJE5SVxf
	uk0yzTO+ATVMIE1IaRSV56MAQeraUSu0+F2kxwGqsIWfM2b0B1RPB7O/hoktZs1p8VCYvgUPEu/
	nG2Xl7Kpkm9L1
X-Received: by 2002:ac2:4f14:0:b0:4fe:494b:3769 with SMTP id k20-20020ac24f14000000b004fe494b3769mr5409090lfr.33.1691066551071;
        Thu, 03 Aug 2023 05:42:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcSrtyaTfvbW1un5x4OA2V0PmTOG0vx/3ukK215u4e/ZhL/EloFZvQu/W8SYZkUViQ3rzh4A==
X-Received: by 2002:ac2:4f14:0:b0:4fe:494b:3769 with SMTP id k20-20020ac24f14000000b004fe494b3769mr5409072lfr.33.1691066550673;
        Thu, 03 Aug 2023 05:42:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe22da3bc5sm4163717wml.42.2023.08.03.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:42:30 -0700 (PDT)
Date: Thu, 3 Aug 2023 14:42:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Arseniy Krasnov <oxffffaa@gmail.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v5 03/14] af_vsock: support multi-transport
 datagrams
Message-ID: <7ioiy325g6bkplp6sqk676sk62wlsxaqy6luwjnnztxsgd3srt@5nh73ct53kr3>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-3-581bd37fdb26@bytedance.com>
 <43fad7ab-2ca9-608e-566f-80e607d2d6b8@gmail.com>
 <ZMrXrBHuaEcpxGwA@bullseye>
 <ZMr6giur//A1hrND@bullseye>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZMr6giur//A1hrND@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 12:53:22AM +0000, Bobby Eshleman wrote:
>On Wed, Aug 02, 2023 at 10:24:44PM +0000, Bobby Eshleman wrote:
>> On Sun, Jul 23, 2023 at 12:53:15AM +0300, Arseniy Krasnov wrote:
>> >
>> >
>> > On 19.07.2023 03:50, Bobby Eshleman wrote:
>> > > This patch adds support for multi-transport datagrams.
>> > >
>> > > This includes:
>> > > - Per-packet lookup of transports when using sendto(sockaddr_vm)
>> > > - Selecting H2G or G2H transport using VMADDR_FLAG_TO_HOST and CID in
>> > >   sockaddr_vm
>> > > - rename VSOCK_TRANSPORT_F_DGRAM to VSOCK_TRANSPORT_F_DGRAM_FALLBACK
>> > > - connect() now assigns the transport for (similar to connectible
>> > >   sockets)
>> > >
>> > > To preserve backwards compatibility with VMCI, some important changes
>> > > are made. The "transport_dgram" / VSOCK_TRANSPORT_F_DGRAM is changed to
>> > > be used for dgrams only if there is not yet a g2h or h2g transport that
>> > > has been registered that can transmit the packet. If there is a g2h/h2g
>> > > transport for that remote address, then that transport will be used and
>> > > not "transport_dgram". This essentially makes "transport_dgram" a
>> > > fallback transport for when h2g/g2h has not yet gone online, and so it
>> > > is renamed "transport_dgram_fallback". VMCI implements this transport.
>> > >
>> > > The logic around "transport_dgram" needs to be retained to prevent
>> > > breaking VMCI:
>> > >
>> > > 1) VMCI datagrams existed prior to h2g/g2h and so operate under a
>> > >    different paradigm. When the vmci transport comes online, it registers
>> > >    itself with the DGRAM feature, but not H2G/G2H. Only later when the
>> > >    transport has more information about its environment does it register
>> > >    H2G or G2H.  In the case that a datagram socket is created after
>> > >    VSOCK_TRANSPORT_F_DGRAM registration but before G2H/H2G registration,
>> > >    the "transport_dgram" transport is the only registered transport and so
>> > >    needs to be used.
>> > >
>> > > 2) VMCI seems to require a special message be sent by the transport when a
>> > >    datagram socket calls bind(). Under the h2g/g2h model, the transport
>> > >    is selected using the remote_addr which is set by connect(). At
>> > >    bind time there is no remote_addr because often no connect() has been
>> > >    called yet: the transport is null. Therefore, with a null transport
>> > >    there doesn't seem to be any good way for a datagram socket to tell the
>> > >    VMCI transport that it has just had bind() called upon it.
>> > >
>> > > With the new fallback logic, after H2G/G2H comes online the socket layer
>> > > will access the VMCI transport via transport_{h2g,g2h}. Prior to H2G/G2H
>> > > coming online, the socket layer will access the VMCI transport via
>> > > "transport_dgram_fallback".
>> > >
>> > > Only transports with a special datagram fallback use-case such as VMCI
>> > > need to register VSOCK_TRANSPORT_F_DGRAM_FALLBACK.
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > >  drivers/vhost/vsock.c                   |  1 -
>> > >  include/linux/virtio_vsock.h            |  2 --
>> > >  include/net/af_vsock.h                  | 10 +++---
>> > >  net/vmw_vsock/af_vsock.c                | 64 ++++++++++++++++++++++++++-------
>> > >  net/vmw_vsock/hyperv_transport.c        |  6 ----
>> > >  net/vmw_vsock/virtio_transport.c        |  1 -
>> > >  net/vmw_vsock/virtio_transport_common.c |  7 ----
>> > >  net/vmw_vsock/vmci_transport.c          |  2 +-
>> > >  net/vmw_vsock/vsock_loopback.c          |  1 -
>> > >  9 files changed, 58 insertions(+), 36 deletions(-)
>> > >
>> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > > index ae8891598a48..d5d6a3c3f273 100644
>> > > --- a/drivers/vhost/vsock.c
>> > > +++ b/drivers/vhost/vsock.c
>> > > @@ -410,7 +410,6 @@ static struct virtio_transport vhost_transport = {
>> > >  		.cancel_pkt               = vhost_transport_cancel_pkt,
>> > >
>> > >  		.dgram_enqueue            = virtio_transport_dgram_enqueue,
>> > > -		.dgram_bind               = virtio_transport_dgram_bind,
>> > >  		.dgram_allow              = virtio_transport_dgram_allow,
>> > >
>> > >  		.stream_enqueue           = virtio_transport_stream_enqueue,
>> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > > index 18cbe8d37fca..7632552bee58 100644
>> > > --- a/include/linux/virtio_vsock.h
>> > > +++ b/include/linux/virtio_vsock.h
>> > > @@ -211,8 +211,6 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
>> > >  u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
>> > >  bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
>> > >  bool virtio_transport_stream_allow(u32 cid, u32 port);
>> > > -int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>> > > -				struct sockaddr_vm *addr);
>> > >  bool virtio_transport_dgram_allow(u32 cid, u32 port);
>> > >
>> > >  int virtio_transport_connect(struct vsock_sock *vsk);
>> > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > > index 305d57502e89..f6a0ca9d7c3e 100644
>> > > --- a/include/net/af_vsock.h
>> > > +++ b/include/net/af_vsock.h
>> > > @@ -96,13 +96,13 @@ struct vsock_transport_send_notify_data {
>> > >
>> > >  /* Transport features flags */
>> > >  /* Transport provides host->guest communication */
>> > > -#define VSOCK_TRANSPORT_F_H2G		0x00000001
>> > > +#define VSOCK_TRANSPORT_F_H2G			0x00000001
>> > >  /* Transport provides guest->host communication */
>> > > -#define VSOCK_TRANSPORT_F_G2H		0x00000002
>> > > -/* Transport provides DGRAM communication */
>> > > -#define VSOCK_TRANSPORT_F_DGRAM		0x00000004
>> > > +#define VSOCK_TRANSPORT_F_G2H			0x00000002
>> > > +/* Transport provides fallback for DGRAM communication */
>> > > +#define VSOCK_TRANSPORT_F_DGRAM_FALLBACK	0x00000004
>> > >  /* Transport provides local (loopback) communication */
>> > > -#define VSOCK_TRANSPORT_F_LOCAL		0x00000008
>> > > +#define VSOCK_TRANSPORT_F_LOCAL			0x00000008
>> > >
>> > >  struct vsock_transport {
>> > >  	struct module *module;
>> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > > index ae5ac5531d96..26c97b33d55a 100644
>> > > --- a/net/vmw_vsock/af_vsock.c
>> > > +++ b/net/vmw_vsock/af_vsock.c
>> > > @@ -139,8 +139,8 @@ struct proto vsock_proto = {
>> > >  static const struct vsock_transport *transport_h2g;
>> > >  /* Transport used for guest->host communication */
>> > >  static const struct vsock_transport *transport_g2h;
>> > > -/* Transport used for DGRAM communication */
>> > > -static const struct vsock_transport *transport_dgram;
>> > > +/* Transport used as a fallback for DGRAM communication */
>> > > +static const struct vsock_transport *transport_dgram_fallback;
>> > >  /* Transport used for local communication */
>> > >  static const struct vsock_transport *transport_local;
>> > >  static DEFINE_MUTEX(vsock_register_mutex);
>> > > @@ -439,6 +439,18 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>> > >  	return transport;
>> > >  }
>> > >
>> > > +static const struct vsock_transport *
>> > > +vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
>> > > +{
>> > > +	const struct vsock_transport *transport;
>> > > +
>> > > +	transport = vsock_connectible_lookup_transport(cid, flags);
>> > > +	if (transport)
>> > > +		return transport;
>> > > +
>> > > +	return transport_dgram_fallback;
>> > > +}
>> > > +
>> > >  /* Assign a transport to a socket and call the .init transport callback.
>> > >   *
>> > >   * Note: for connection oriented socket this must be called when vsk->remote_addr
>> > > @@ -475,7 +487,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> > >
>> > >  	switch (sk->sk_type) {
>> > >  	case SOCK_DGRAM:
>> > > -		new_transport = transport_dgram;
>> > > +		new_transport = vsock_dgram_lookup_transport(remote_cid,
>> > > +							     remote_flags);
>> >
>> > I'm a little bit confused about this:
>> > 1) Let's create SOCK_DGRAM socket using vsock_create()
>> > 2) for SOCK_DGRAM it calls 'vsock_assign_transport()' and we go here, remote_cid == -1
>> > 3) I guess 'vsock_dgram_lookup_transport()' calls logic from 0002 and returns h2g for such remote cid, which is not
>> >    correct I think...
>> >
>> > Please correct me if i'm wrong
>> >
>> > Thanks, Arseniy
>> >
>>
>> As I understand, for the VMCI case, if transport_h2g != NULL, then
>> transport_h2g == transport_dgram_fallback. In either case,
>> vsk->transport == transport_dgram_fallback.
>>
>> For the virtio/vhost case, temporarily vsk->transport == transport_h2g,
>> but it is unused because vsk->transport->dgram_bind == NULL.
>>
>> Until SS_CONNECTED is set by connect() and vsk->transport is set
>> correctly, the send path is barred from using the bad transport.
>>
>> I guess the recvmsg() path is a little more sketchy, and probably only
>> works in my test cases because h2g/g2h in the vhost/virtio case have
>> identical dgram_addr_init() implementations.
>>
>> I think a cleaner solution is maybe checking in vsock_create() if
>> dgram_bind is implemented. If it is not, then vsk->transport should be
>> reset to NULL and a comment added explaining why VMCI requires this.
>>
>> Then the other calls can begin explicitly checking for vsk->transport ==
>> NULL.
>
>Actually, on further reflection here, in order for the vsk->transport to
>be called in time for ->dgram_addr_init(), it is going to be necessary
>to call vsock_assign_transport() in vsock_dgram_bind() anyway.
>
>I think this means that the vsock_assign_transport() call can be removed
>from vsock_create() call entirely, and yet VMCI can still dispatch
>messages upon bind() calls as needed.
>
>This would then simplify the whole arrangement, if there aren't other
>unseen issues.

This sounds like a good approach.

My only question is whether vsock_dgram_bind() is always called for each
dgram socket.

Stefano


