Return-Path: <bpf+bounces-2749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D473377C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257761C20FE3
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289571D2A6;
	Fri, 16 Jun 2023 17:32:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182019E69
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:32:40 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8341FD7
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:32:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25ecc896007so25665a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686936759; x=1689528759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBJ7Q5HhgZEG8ETmSKNrkoS2bGXZOSjRMyByDqjDs+g=;
        b=UOwmES8cIwbbqpUEaeGsTw49f6IAJzGh3+t4SR9VzABUaSxTbA4/QF05M/zufqz+J4
         ae0uA8qFg4VjAGkI3Xo39NSxixpHKm+srnPK/hnVFehdRNX07WGQmw9Z/tbdsU/LS6wH
         IPA6h3aIkho4v+ST+m071b2Aw9Ryzzg76PQp9afdc434aLnOEeb5K1UyRIZ5nOIfZM18
         SP/M8cpfY+L6MrTW7ClilQbCiZrACZ71o4lh2ZbcaypMUgnab1vVAcqHqt6LpwJuSVns
         lbA6Bt9KjihBTG5WDalfVcTZLbrjL+pWe6Fq8bmwbJxL9eofbooyk/Qb8FUHMuljD8b5
         gl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936759; x=1689528759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBJ7Q5HhgZEG8ETmSKNrkoS2bGXZOSjRMyByDqjDs+g=;
        b=N/6pnSSBE0H1V5QrPkX939rqIOUR/qsiDA8/6D5x+gqCzLzX4z6yfwzufyRePATbkb
         pbYDIdbvHyGShQwk9O/hacjfnd9Mr/NJ6Q7yPK2Ehxryt6U5YXNHYcMS3KNpfQ1u525c
         MGsTVLluzR2GeeQBgkEci2mARuacDTddcp6cdDczMSnHH31YeagS4j8CpGsSzVMhEGD/
         Y9WGo9Hp9Naxe87aaSqxRMSMFcmVPaspAAa0FhY2pQfg62cKLt4Tg7DjpbAtYPhSNxJX
         Zi7VBqzQt5jUMknRFQ2MN4hdKk1R0sxiM8L9139NKrVdY3QHPqpduGVCIw4z3unGcMXX
         N/8A==
X-Gm-Message-State: AC+VfDwoz7wYmZcDwtunS69uajE8Hx8GwXvpe21IsZMbLOO8Z5jLOLq1
	7EVC7SnX/4HE+x0WdQaEWTKTolWl0THCLWxzN1HUzQ==
X-Google-Smtp-Source: ACHHUZ6oMWe0k1326ySqQfjgqmz7DPGgzkRkh14ZKZzbGtyjFSRxPv1qMpcSgBWwgIIE5yvWjna9IQSMcQYBFF760M4=
X-Received: by 2002:a17:90a:be0b:b0:25d:e433:c2b9 with SMTP id
 a11-20020a17090abe0b00b0025de433c2b9mr2257265pjs.18.1686936759003; Fri, 16
 Jun 2023 10:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612172307.3923165-1-sdf@google.com> <20230612172307.3923165-4-sdf@google.com>
 <1fb38d17-619d-4cd9-30e4-624d2ee21a2b@gmail.com>
In-Reply-To: <1fb38d17-619d-4cd9-30e4-624d2ee21a2b@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 16 Jun 2023 10:32:27 -0700
Message-ID: <CAKH8qBt1hk2Gi0tj+j5LD7nphatZN_BbSOFwY8hgjBp6D9Xh4w@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/7] bpf: implement devtx hook points
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 10:47=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 6/12/23 10:23, Stanislav Fomichev wrote:
> ..... cut .....
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +               "Global functions as their definitions will be in vmlin=
ux BTF");
> > +
> > +/**
> > + * bpf_devtx_sb_attach - Attach devtx 'packet submit' program
> > + * @ifindex: netdev interface index.
> > + * @prog_fd: BPF program file descriptor.
> > + *
> > + * Return:
> > + * * Returns 0 on success or ``-errno`` on error.
> > + */
> > +__bpf_kfunc int bpf_devtx_sb_attach(int ifindex, int prog_fd)
> > +{
> > +     struct net_device *netdev;
> > +     int ret;
> > +
> > +     netdev =3D dev_get_by_index(current->nsproxy->net_ns, ifindex);
> > +     if (!netdev)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&devtx_attach_lock);
> > +     ret =3D __bpf_devtx_attach(netdev, prog_fd, "devtx_sb", &netdev->=
devtx_sb);
> > +     mutex_unlock(&devtx_attach_lock);
> > +
> > +     dev_put(netdev);
> > +
> > +     return ret;
> > +}
>
> How about adding another detach kfunc instead of overloading
> this one? It is easier to understand.

Originally I was planning to switch to links which would have avoided
the need of an explicit detach.
But, as discussed, I'll drop it all for v2 and will go with regular fentry.

