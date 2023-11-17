Return-Path: <bpf+bounces-15229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBD7EF270
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965E51C20835
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203BC30657;
	Fri, 17 Nov 2023 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i57dwncU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5541A5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:14:55 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7afd45199so21863317b3.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700223295; x=1700828095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgOAMjlODvJ+YNEZ7Ca2M+B0RgguYv9rt1VuNyeRQPs=;
        b=i57dwncURzYPJkLQ7JD9HV+pKJp5zYjlZyrDz0TVsAbcoOXxiv71H8q8mZBXUMEiSz
         vNvN/djU4EAmNb5vN3Svm4lxGVO72a4c7jZUmhEWgVWeC6U8VzXwdcqonoPRRVKhUO2B
         +CxEFLHOzreePTTpv15voQick7Ej/S3mMHeMNIwQp+33TbQ5hSu0oOcMu+6UyzyXXFaR
         qK//2UqStZMtRy697HuVF1dOWfKxu3ww94W3Vq30ECvD6pgBkvRgOlbGl77b7xTRl6IJ
         jXlofTAekOrSrA8aVGhPwVV9Jl4LreXm4LPdlpnGBtO8+dW+sg2W4bUfyAdimMqvaOUv
         a9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700223295; x=1700828095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgOAMjlODvJ+YNEZ7Ca2M+B0RgguYv9rt1VuNyeRQPs=;
        b=lEM69UxdMO3Wgb2Jrqh/MvsxTBuS98f3chYogyanlBZtfa6MdSbx0zCu1KWREWs7j/
         +RJitkpJU9bfHTLmCQvUFVDzuVj1TxixmPDdLSLd2TsEbB3d3y8KSlodqy32c7gEhMe0
         9Em8SFQzH2GekJmOl6x8+WC1qOs1ChxeZLFFs68jdGWmPjJofL7qRo/ERRLJRRTb2Bh1
         unBNU5Tfw7P3Z0tq0cWMOHrf8PBIuqREM7w0FQ3ICBZfY8rivzVZWzZVOHJZPwYcXc6y
         zoR8n1sZVeaW9lGwuNEWu/+swY2yngdy4lpfWoEaxZVjg3yoNvq+4c0ZpfmhacBp3dcS
         fSLg==
X-Gm-Message-State: AOJu0YzRxtAWORnTSPIVtLjFWCX1rD0WmxZ3JpfiL/hhI5BRcpHnGpzu
	kPbjAxvto17z0WuHNpMBHxuT8C6Km0oXZgNLcGXNLw==
X-Google-Smtp-Source: AGHT+IEPatPHM2gFy8KKGyowHxgUDA3/uw8emCLwjo1Xb0hGpq66gkDDQUG9sGVa/R1HknegWd5Rml9Rnv/11E0Vdes=
X-Received: by 2002:a81:8a41:0:b0:5a7:b464:ff1a with SMTP id
 a62-20020a818a41000000b005a7b464ff1amr18137851ywg.6.1700223294935; Fri, 17
 Nov 2023 04:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-16-jhs@mojatatu.com>
 <ZVZGYQDk/LyC7+8z@nanopsycho>
In-Reply-To: <ZVZGYQDk/LyC7+8z@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 17 Nov 2023 07:14:43 -0500
Message-ID: <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 15/15] p4tc: Add P4 extern interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:42=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:
>
> [...]
>
> > include/net/p4tc.h                |  161 +++
> > include/net/p4tc_ext_api.h        |  199 +++
> > include/uapi/linux/p4tc.h         |   61 +
> > include/uapi/linux/p4tc_ext.h     |   36 +
> > net/sched/p4tc/Makefile           |    2 +-
> > net/sched/p4tc/p4tc_bpf.c         |   79 +-
> > net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++++++
> > net/sched/p4tc/p4tc_pipeline.c    |   34 +-
> > net/sched/p4tc/p4tc_runtime_api.c |   10 +-
> > net/sched/p4tc/p4tc_table.c       |   57 +-
> > net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
> > net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
> > net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++++
> > 13 files changed, 5083 insertions(+), 10 deletions(-)
>
> This is for this patch. Now for the whole patchset you have:
>  30 files changed, 16676 insertions(+), 39 deletions(-)
>
> I understand that you want to fit into 15 patches with all the work.
> But sorry, patches like this are unreviewable. My suggestion is to split
> the patchset into multiple ones including smaller patches and allow
> people to digest this. I don't believe that anyone can seriously stand
> to review a patch with more than 200 lines changes.

This specific patch is not difficult to split into two. I can do that
and send out minus the first 8 trivial patches - but not familiar with
how to do "here's part 1 of the patches" and "here's patchset two".
There's dependency between them so not clear how patchwork and
reviewers would deal with it. Thoughts?

Note: The code machinery is really repeatable; for example if you look
at the tables control you will see very similar patterns to actions
etc. i.e spending time to review one will make it easy for the rest.

cheers,
jamal

> [...]

