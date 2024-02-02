Return-Path: <bpf+bounces-21047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B219A846FA5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E406C1C24906
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6AA13DBA8;
	Fri,  2 Feb 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hwDVqkhD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF113E202
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875229; cv=none; b=StteH11CpgIT8awLrOkzP+rYNEFNLEoj+JlwrtNNt49uiqbvpTJjZfG3751634OA6lF38PB9Lfxz8ezx2eq9sdoZVgdQHyTx6zb8XxGvh6k81PwlE+XSf//7VkDoSe3O/qcpTac1Ax0m8WIm5nZBKrEWtJnBagKSgffuXXnkZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875229; c=relaxed/simple;
	bh=Xr1DXbAvTDaR865LAL/0PwG1Pwk9T4vlzO6plLsxOsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffTRsf8n/x7D+qZcEKq6QCHbhGEemVgb2pR/pAiMSFX5xamZEXV2Rn18W0Ph0OTUpkTL6TuJbcAHw83Jm6Z+ul3lKfO4t8dDTYe9ae+y7k2X6gyhnxTZifeVS6yBSyHZxbNkbsFza0ADLybI/PuW6OfIiBL9JIwlTSJl+/ML3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hwDVqkhD; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6dd9bf348so1569480276.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875227; x=1707480027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzLbrSJJ3HMQY02UX2KoRZJkzmC3g7dnGPcxrBeDXSI=;
        b=hwDVqkhDkcKt0ksOQ2MzNGjj8oKqKtGcTEqadeVU3vru9E74WoyVaaKQPqXrBfz4eY
         pbxN7M4oVD1oXc+DwsbbTaX22aQ96b1isN1ntGVKXQlVDVd8pqvpzf4+yG9V8qdMMYiG
         hLqC42AD4wqQdtVGddvF1J2Rnx8YgeZrTqZoVSfcs+s/0uIDTjdb7BBRJyl4QD98hl7H
         ejMNvsNb4/0O4icpqjVW2E1b+/GeBAbwRKpLPAZew8SzMOV8rRYv04A8sxzNsn1AEORj
         jAtExYslHiPP1ke86FsUAfcaYxQgVGB0WPttWLcxY1X58qMwPPIj1Fi09Qs0fvaowMQp
         afqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875227; x=1707480027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzLbrSJJ3HMQY02UX2KoRZJkzmC3g7dnGPcxrBeDXSI=;
        b=Q3hDjdVBHAEKrxw9UEblLnk/oVEJ66TP3v6faobnbMBnp95gnb2/7vxXWMJD+BB9E5
         M89gp3NFSH5jNjKCwNP6ZRH64DZ/ICaTTMwiVq6Nw0UfeK+PWFm2t5keUCW1UnbcnBbX
         WQ65YE2YNE+xnQ+1vpWfP9d4kHfN9RPcfACEPiU5sUVyAMhHhQ4m5Eb/F2+OGXenJccd
         Od/JtVLkYsCUPPxIEu0JlhTR6SS3QIlCUFM6jd8ANMV6TTdVEieiuNKsJnl+w0etF0Qe
         khJnlQ1g4Iz/67hCAnftzRrw8x9ysQiLOwB0nkzj/zFv5SqjV3RX+YauhI855eExogBY
         zzgA==
X-Gm-Message-State: AOJu0YxivKJaSXkyZKGVmINzJrQsfl1/oym9TV1dMtnK9qJiANZot6UO
	ijQjgCjo1G587ouaL1UQsNkel4q0ifGpyBBRBxufTq2WRlJ+00n3TP99anMBG9s2dMTmDdidChS
	VjcT14mItI4xdIlFbtQI+dzHuXULueHaizmGT
X-Google-Smtp-Source: AGHT+IHQ6wzlg9F8HWhoQrUEoJLbXNbanj7A3PlVRUx0Gcct6/Z9FQkJVgMpw7no9GZg5v1QMrcLNSuo1+vtdtEx7A0=
X-Received: by 2002:a25:698b:0:b0:dc6:b974:68cb with SMTP id
 e133-20020a25698b000000b00dc6b97468cbmr5340100ybc.31.1706875226922; Fri, 02
 Feb 2024 04:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-3-jhs@mojatatu.com>
 <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
In-Reply-To: <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:00:15 -0500
Message-ID: <CAM0EoMkkQ2tVq7a2ECjkyfWjxLVqvmA2wuN+Su8QUW7TM5tGGQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 02/15] net/sched: act_api: increase action
 kind string length
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:16=E2=80=AFAM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:48PM -0500, Jamal Hadi Salim wrote:
> > @@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr=
 *nla,
> >                       NL_SET_ERR_MSG(extack, "TC action kind must be sp=
ecified");
> >                       return ERR_PTR(err);
> >               }
> > -             if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
> > +             if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
> >                       NL_SET_ERR_MSG(extack, "TC action name too long")=
;
> >                       return ERR_PTR(err);
> >               }
>
> Subsquent lines here are:
>         } else {
>                 if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
>                                                 ^^^^^^^^
>                         NL_SET_ERR_MSG(extack, "TC action name too long")=
;
>
> I know it won't make a difference in the end but it would be nice to
> keep it consistent.

Agreed. It was an oversight. Will fix it in the next version.
Thanks for the rest of your reviews Marcelo!

cheers,
jamal

