Return-Path: <bpf+bounces-10528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE477A980D
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14514B20FAF
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5112B6D;
	Thu, 21 Sep 2023 17:08:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443ED9461
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:08:15 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356FB17C3C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:07:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c382f23189so8335ad.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316066; x=1695920866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=voHI+myx5oZuGt4zp4/ZkYGNxaFIMS4YD9qFVs97HE9Tyjy/LarpZ5G4Qcx2pHWJax
         5nimb1szezSZOUmUBxxi8jPKhtta80o7xtEFnrPvmUelz9qNN/UcKkuaQ2KXRVCyjOe6
         i6NcmcgfGUgNFZRTiARln8EyCbX/3cToL0VDjk32A69mpI4Gu22paFNv8f2yXmVcGj0L
         cDiVUK/EK/2xkeXGPV8i5JB4KkCoDsIdW/tv2tr56RBcwC0yhEXEKN7naA6oWWCdfN0a
         6/6yxjIW+FaSRUlT86TpJWV6ckOL5ZpjsWqrWV8ezlaMwb+gjf+LycezuUEphIiKvz8s
         cr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316066; x=1695920866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=so0Kdo6uGb7C0vEltzDFhGMo4NMO6by3Bw2VTjMDUEShE+wJBKVgOgaTtRP/YFjpe6
         2X2l9GwxEIY4GSCpl/JBKg2igz9ePJKWKpqFtGuJiwgqyCn/X7oH/KWLyO0qYSf2JTtd
         PPAETrbg4j4EoOtiMTyT6L9aQcniSeBxdz1ORYcOKba5zVlDyd9jUK8VUjdWmOPJEnl0
         8xpLYpbNzotPXqsxhq5DBfCG9z4rDgEx0uCt8W+/uyXedB8cZIdgpyER7jhHWnVfxlLS
         QD+uVPPnoNu8LV1H17oidd9rcKsIvlSTaS69l8wCIdNY+zmjzilOU7KpPD0Xv9v4AjN4
         wNkA==
X-Gm-Message-State: AOJu0Ywqo9GwI/Z+kmHr99szZtn/jYikio0KUeMAEwy7E+x9OLgs9EVl
	UuyS3kzTrEq2wJJgtYblkE5t3TK86RNPJhGG986gmaCIm0d5XDc0JG4=
X-Google-Smtp-Source: AGHT+IFWIeurUPvjpL8vBL+NRQRjjve76EQFHIAx0HeE7Z69wb2lo8venh8x2KPWv7LuxH/KDV+UnqVPhre4/L2Akrw=
X-Received: by 2002:ac8:5b11:0:b0:403:e1d1:8b63 with SMTP id
 m17-20020ac85b11000000b00403e1d18b63mr211399qtw.24.1695294572440; Thu, 21 Sep
 2023 04:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <730408.1695292879@warthog.procyon.org.uk>
In-Reply-To: <730408.1695292879@warthog.procyon.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 13:09:21 +0200
Message-ID: <CANn89i+wUq5R2nFO8eGLp7=8Y5OiJ0fwjR+ES74gk1X4k9r0rw@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
>
> The symptom observed is a warning in __ip6_append_data():
>
>     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_=
data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
>
> that occurs when MSG_SPLICE_PAGES is used to append more data to an alrea=
dy
> partially occupied skbuff.  The warning occurs when 'copy' is larger than
> the amount of data in the message iterator.  This is because the requeste=
d
> length includes the transport header length when it shouldn't.  This can =
be
> triggered by, for example:
>
>         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
>         bind(sfd, ...); // ::1
>         connect(sfd, ...); // ::1 port 7
>         send(sfd, buffer, 4100, MSG_MORE);
>         sendfile(sfd, dfd, NULL, 1024);
>
> Fix this by only adding transhdrlen into the length if the write queue is
> empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.
>
> l2tp_ip_sendmsg() looks like it won't suffer from this problem as it buil=
ds
> the UDP packet itself.
>
> Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for=
 IPv6")
> Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: netdev@vger.kernel.org
> cc: bpf@vger.kernel.org
> cc: syzkaller-bugs@googlegroups.com
> ---

Looks safer indeed, thanks to you and Willem !

Reviewed-by: Eric Dumazet <edumazet@google.com>

