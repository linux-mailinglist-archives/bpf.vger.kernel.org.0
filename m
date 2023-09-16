Return-Path: <bpf+bounces-10200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196807A2E7F
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 10:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A18B2821E8
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379A10971;
	Sat, 16 Sep 2023 08:06:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAD1FA3
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 08:06:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C576719A9
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694851583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcJhU9yrJlYW0JwS0jBHn6K5F5PsCG42wfINjuYLJv4=;
	b=P2uUVTucUvOsJEEYGUN9+s0H8vPzcIKpDhryRAyNB8bVUN/ncCjgUnDFQ70ncAJiEtQdEq
	0LSlVWrWs9wMtSbRdw0COnO7bNHvKQeojCfx+tOWKsOP7hvldrEznivGa7qjx176Ah/Bnt
	HZCNblsSc1WuuJyKcfm0On3r5i/Rtpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jgvmdjwWPqGDrzwYeaU5Cw-1; Sat, 16 Sep 2023 04:06:20 -0400
X-MC-Unique: jgvmdjwWPqGDrzwYeaU5Cw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe12bf2db4so7611075e9.0
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 01:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694851579; x=1695456379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcJhU9yrJlYW0JwS0jBHn6K5F5PsCG42wfINjuYLJv4=;
        b=GojbfforYXS1FmPD5WIzab3oDlYXjIioSQxT1DMf8rL8WKlXoIgqGRk1F5Ar9EPL8P
         0ca/dxWYBSPxLAr5vw8drYNxsaI3aTZHiiOTgoJgUvyQROEiLgrUDSBHML2qg0r7PZkj
         VBQhsHXj/r1XZyxX4gfyXKwRFWzLr0zijl5tsw6QAUw0LlVVjBCNNHBjFR/2aij7zs/T
         GOLStr/zQtMGwrcVlYFKzEBGjD7B9t+m0gG0dq4ZaRPW3d8FJJ28RK3NLbMhD/FeZk1c
         brb3PrAHuvRpM0dkq1NJmgAAG0dZfbaxADsXBst70Rp/5IacYVhPwYow0Z3FZ1kpS8qM
         4Zlg==
X-Gm-Message-State: AOJu0YyM03geu4L7hQKzrITUORUD5wCzHQ2I0EWJGsJPyViHDseZYFWp
	djKpwwRJhDXD0BoG+eknqveaWbakVxJ45DOyGeT9J344VekreLQh4Nh44SA7bHQ99XoAneKFhC/
	pHD7B0fXfJf7m
X-Received: by 2002:a5d:484a:0:b0:31a:ea18:c516 with SMTP id n10-20020a5d484a000000b0031aea18c516mr3147684wrs.3.1694851578981;
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYkkZ6CMVhyAAiIEGRVoXQz3vuRoMHD4ya1yYkGxrjzwQNYpC4iSPnOTwMZM/ai1A1Yyxuvg==
X-Received: by 2002:a5d:484a:0:b0:31a:ea18:c516 with SMTP id n10-20020a5d484a000000b0031aea18c516mr3147663wrs.3.1694851578612;
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-149.dyn.eolo.it. [146.241.247.149])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5008000000b0031f8be5b41bsm6485441wrt.5.2023.09.16.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
Message-ID: <e7185c2f7f84f5f88c08bec2a986afb5851c2d4e.camel@redhat.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
From: Paolo Abeni <pabeni@redhat.com>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>, 
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
  daniel@iogearbox.net, jackmanb@google.com, renauld@google.com, 
 casey@schaufler-ca.com, song@kernel.org, revest@chromium.org
Date: Sat, 16 Sep 2023 10:06:16 +0200
In-Reply-To: <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
	 <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
	 <63e525a8.170a0220.e8217.2fdb@mx.google.com>
	 <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
	 <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
	 <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
	 <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
	 <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I'm sorry for the duplicate, I did a quick reply via the gmail UI and
that unintentionally inserted html. Retrying with a real email client.

On Sat, 2023-09-16 at 02:57 +0200, KP Singh wrote:
> On Wed, Jul 26, 2023 at 1:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > Looking at patch 4/4 from this series, it *think* it's doable to
> > extract it from the series and make it work standalone. If so, would
> > that approach be ok from a LSM point of view?
>=20
> I will rev up the series again. I think it's worth fixing both issues
> (performance and this side-effect). There are more users who have been
> asking me for performance improvements for LSMs

FTR, I'm also very interested in the performance side of the thing.

My understanding is that Paul asks the 'side-effect' issue being
addressed before/separately.

To that extent I shared a slightly different approach here:

https://lore.kernel.org/linux-security-module/cover.1691082677.git.pabeni@r=
edhat.com/

with the hope it could be 'cleaner' and allow building the indirect
call avoidance on top.

I would appreciate it if you could take a look there, too!

Thanks,

Paolo



