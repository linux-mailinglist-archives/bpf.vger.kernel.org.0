Return-Path: <bpf+bounces-41734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA5999FEC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3FA1C21E3F
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3720CCE1;
	Fri, 11 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQKSTmbh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9791F942E;
	Fri, 11 Oct 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638237; cv=none; b=pkawsxwbGv0mt9+1wlheTiZRfPuetLew2K5MKWW06PHzW6PcgISvm/iOWpBU6+ujyZIi8qZu5CQgQDYJPMrdvbp3UblDhP6LdRtRIzdqsypUuuZz2vZgLBdap7lN5SZl4LBISJKPtXPvaVNMQSgsV6XduXXpE8yOAlxkr8G/uPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638237; c=relaxed/simple;
	bh=mSAzwM/8sS+JtnChrMTuA5DiAMd2DZhhFzYl91I4NrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMMUM8b3aaOirdzuZaenZmM+mg3t8vQC9FRFuraHgZZkZvefktHCq8Cs76uSExebiImHx4Um1Ih5oJNzGE8RlMc9jn0sZXAsjynrC+Et6ZTUlCeqv+r1/kmHxmnpIrD/YQdfNXt5ULjr0S9nd2i4nuXNqj6DPABBGo6UJ8qyR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQKSTmbh; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6e2e3e4f65dso19324067b3.3;
        Fri, 11 Oct 2024 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728638235; x=1729243035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18Z9ZZFMKWTO+swtTiyyp/2jw2Tfm683OGb7o6rVXn0=;
        b=EQKSTmbhBLcBCwESiJV5R8Dzztm6oGBaDwC41X1UWov4585OjRUXyK6ES57VYRhfu1
         6YUy/tassktmGC2OUrIKip9Yv6ElVVD37TEdbG3nfJOu0FDhJ5E1WlXwN2PWn9+jck1l
         lcc6YMmrLoNJihoaYLOWvZCJQymnA8D5qyO8bFnp6xSUjq432cy4FYijmZIIAD/a9an1
         xCjgjjQwZQmROx0qlxG6prCouC9I7TP13RtQtgTuAskqv5xASZn33U24vXGUCBv3btpg
         vl6E9KN4RkV3rYx3uKCnr/30Z3sKaZaUzRivxlUtADThX1RKBaQfZooH0cyYVQi54Ako
         jc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638235; x=1729243035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18Z9ZZFMKWTO+swtTiyyp/2jw2Tfm683OGb7o6rVXn0=;
        b=d459u3524QJgDJ7Vg5Dd+PucwU2Ab+D7+3oBJVXyF6i7bQ2J/J7SojAyyP3ISJvcLQ
         NvHvocof+O0cz+a4BxPCbqAfxOFmPGfc4Ojs81AU5lBRCtqtP+TiNfyJ5821HvKqttBJ
         +bGBDIiuHMxlEorevGDyJ020tZiTc6t1dPnDCEh/uZm/CafukogojCa/2KZN9dakl2jg
         NlQiuFYA54LoOT8ZSAdFoTggT9ClgU5zc9CtlJoMeNM2NhEFp8HKwbvC2Gh+DrkOk5zr
         4bdvF6IyY7IVYJZPXJs+dHx8og2c/FICxDY+bZxwC68AmFKQSim8ruus3vZld7iX144N
         38bg==
X-Forwarded-Encrypted: i=1; AJvYcCUJhnEVf+NRJCKcUaltB5xT0ZT+GraB1il91YXfY9SuaG7tIhwRIKN/65QiW4TbOYjswf83/IA2@vger.kernel.org, AJvYcCWWVKfOU5Lb0tO3NjYr7q+uYdmo+YutDyHxBn17AO0cXwiSnFkphiMhxND8lxJ/jHXKLMQ=@vger.kernel.org, AJvYcCXFcJpvFL+BShLfCUotFEhFk0RIbiWZV7WfMt8NOiPWTO57z6wskdtdRiUWy3TpFJH2SWjAGkp8PlU2cqfL@vger.kernel.org
X-Gm-Message-State: AOJu0YwNClJ+db1XGEfYCuwTIG1kdYKdeYfObYUw+GwUTXxeQ60JTN9A
	HEpnX95LGJRRqkY+mKQmcEd6g555vJ//376aa+Bgm9lPeWV84ogSLCGs3rmYt2mqVnkc4Rgb5cS
	Xk8gSoLQ7wg4tWZ1fatuevcyT2lt32Fdy2Rc=
X-Google-Smtp-Source: AGHT+IEoANVtjt+0i61XgjrMl8C6Cvp4x/IScnsqx8O1GWHfLzoWL0U1jelD15+ZuI3He60EewD9Ttn2D5M9g/z/uBU=
X-Received: by 2002:a05:690c:7446:b0:6e3:2b25:8972 with SMTP id
 00721157ae682-6e3479ff869mr15040087b3.21.1728638234696; Fri, 11 Oct 2024
 02:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn> <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
 <CADxym3baw2nLvANd-D5D2kCNRRoDmdgexBeGmD-uCcYYqAf=EQ@mail.gmail.com>
 <CADxym3ZGR59ojS3HApT30G2bKzht1pbZG212t3E7ku61SX29kg@mail.gmail.com> <60a8fea1-e876-4174-bf32-9524204d63ed@redhat.com>
In-Reply-To: <60a8fea1-e876-4174-bf32-9524204d63ed@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Oct 2024 17:17:57 +0800
Message-ID: <CADxym3ZRBK-7587uU5FXd6KpfyNyYzGe=+Z7Z0vfV-MntXx1hQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:49=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/11/24 08:42, Menglong Dong wrote:
> > On Thu, Oct 10, 2024 at 5:18=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> >> On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>> On 10/7/24 09:46, Menglong Dong wrote:
> >>>> In this commit, we make fib_validate_source/__fib_validate_source re=
turn
> >>>> -reason instead of errno on error. As the return value of them can b=
e
> >>>> -errno, 0, and 1, we can't make it return enum skb_drop_reason direc=
tly.
> >>>>
> >>>> In the origin logic, if __fib_validate_source() return -EXDEV,
> >>>> LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it =
by
> >>>> checking "reason =3D=3D SKB_DROP_REASON_IP_RPFILTER". However, this =
will take
> >>>> effect only after the patch "net: ip: make ip_route_input_noref() re=
turn
> >>>> drop reasons", as we can't pass the drop reasons from
> >>>> fib_validate_source() to ip_rcv_finish_core() in this patch.
> >>>>
> >>>> We set the errno to -EINVAL when fib_validate_source() is called and=
 the
> >>>> validation fails, as the errno can be checked in the caller and now =
its
> >>>> value is -reason, which can lead misunderstand.
> >>>>
> >>>> Following new drop reasons are added in this patch:
> >>>>
> >>>>     SKB_DROP_REASON_IP_LOCAL_SOURCE
> >>>>     SKB_DROP_REASON_IP_INVALID_SOURCE
> >>>>
> >>>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >>>
> >>> Looking at the next patches, I'm under the impression that the overal=
l
> >>> code will be simpler if you let __fib_validate_source() return direct=
ly
> >>> a drop reason, and fib_validate_source(), too. Hard to be sure withou=
t
> >>> actually do the attempt... did you try such patch by any chance?
> >>>
> >>
> >> I analysed the usages of fib_validate_source() before. The
> >> return value of fib_validate_source() can be -errno, "0", and "1".
> >> And the value "1" can be used by the caller, such as
> >> __mkroute_input(). Making it return drop reasons can't cover this
> >> case.
> >>
> >> It seems that __mkroute_input() is the only case that uses the
> >> positive returning value of fib_validate_source(). Let me think
> >> about it more in this case.
> >
> > Hello,
> >
> > After digging into the code of __fib_validate_source() and __mkroute_in=
put(),
> > I think it's hard to make __fib_validate_source() return drop reasons
> > directly.
> >
> > The __fib_validate_source() will return 1 if the scope of the
> > source(revert) route is HOST. And the __mkroute_input()
> > will mark the skb with IPSKB_DOREDIRECT in this
> > case (combine with some other conditions). And then, a REDIRECT
> > ICMP will be sent in ip_forward() if this flag exists.
> >
> > I don't find a way to pass this information to __mkroute_input
> > if we make __fib_validate_source() return drop reasons. Can we?
> >
> > An option is to add a wrapper for fib_validate_source(), such as
> > fib_validate_source_reason(), which returns drop reasons. And in
> > __mkroute_input(), we still call fib_validate_source().
> >
> > What do you think?
>
> Thanks for the investigation. I see that let __fib_validate_source()
> returning drop reasons does not look like a good design.
>
> I think the additional helper will not help much, so I guess you can
> retain the current implementation here, but please expand the commit
> message with the above information.

Hello,

I have implemented a new version just now like this:

The only caller of __fib_validate_source() is fib_validate_source(), so
we can combine fib_validate_source() into __fib_validate_source(), and
make fib_validate_source() an inline call to __fib_validate_source().

Then, we can make fib_validate_source() return drop reasons. And
we call __fib_validate_source() in __mkroute_input(), which makes
the logic here remains unchanged.

What do you think? Or do we retain the current implementation here?

Following is the part patch that refactor
fib_validate_source/__fib_validate_source:

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 06130933542d..ea51cae24fad 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -448,9 +448,18 @@ int fib_gw_from_via(struct fib_config *cfg,
struct nlattr *nla,
             struct netlink_ext_ack *extack);
 __be32 fib_compute_spec_dst(struct sk_buff *skb);
 bool fib_info_nh_uses_dev(struct fib_info *fi, const struct net_device *de=
v);
-int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-            dscp_t dscp, int oif, struct net_device *dev,
-            struct in_device *idev, u32 *itag);
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+              dscp_t dscp, int oif, struct net_device *dev,
+              struct in_device *idev, u32 *itag);
+
+static inline int
+fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+            dscp_t dscp, int oif, struct net_device *dev,
+            struct in_device *idev, u32 *itag)
+{
+    return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+                     itag);
+}

 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8353518b110a..f74138f4d748 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -341,10 +341,11 @@ EXPORT_SYMBOL_GPL(fib_info_nh_uses_dev);
  * - check, that packet arrived from expected physical interface.
  * called with rcu_read_lock()
  */
-static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 d=
st,
-                 dscp_t dscp, int oif, struct net_device *dev,
-                 int rpf, struct in_device *idev, u32 *itag)
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+              dscp_t dscp, int oif, struct net_device *dev,
+              struct in_device *idev, u32 *itag)
 {
+    int rpf =3D secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
     struct net *net =3D dev_net(dev);
     struct flow_keys flkeys;
     int ret, no_addr;
@@ -352,6 +353,28 @@ static int __fib_validate_source(struct sk_buff
*skb, __be32 src, __be32 dst,
     struct flowi4 fl4;
     bool dev_match;

+    /* Ignore rp_filter for packets protected by IPsec. */
+    if (!rpf && !fib_num_tclassid_users(net) &&
+        (dev->ifindex !=3D oif || !IN_DEV_TX_REDIRECTS(idev))) {
+        if (IN_DEV_ACCEPT_LOCAL(idev))
+            goto last_resort;
+        /* with custom local routes in place, checking local addresses
+         * only will be too optimistic, with custom rules, checking
+         * local addresses only can be too strict, e.g. due to vrf
+         */
+        if (net->ipv4.fib_has_custom_local_routes ||
+            fib4_has_custom_rules(net))
+            goto full_check;
+        /* Within the same container, it is regarded as a martian source,
+         * and the same host but different containers are not.
+         */
+        if (inet_lookup_ifaddr_rcu(net, src))
+            return -EINVAL;
+
+        goto last_resort;
+    }
+
+full_check:
     fl4.flowi4_oif =3D 0;
     fl4.flowi4_l3mdev =3D l3mdev_master_ifindex_rcu(dev);
     fl4.flowi4_iif =3D oif ? : LOOPBACK_IFINDEX;


Thanks!
Menglong Dong

>
> Thanks!
>
> Paolo
>

