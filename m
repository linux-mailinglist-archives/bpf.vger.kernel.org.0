Return-Path: <bpf+bounces-16531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA680207C
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 03:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F61F20F70
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1730816;
	Sun,  3 Dec 2023 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWcMTMpF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042ADFC;
	Sat,  2 Dec 2023 18:58:25 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-423e8145018so26275781cf.1;
        Sat, 02 Dec 2023 18:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701572304; x=1702177104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5PSqWkt2q0NsH/cezKyOksOI/ZTMxsuCeNKgtqCwp4=;
        b=SWcMTMpF4DAbotdE8b5BikvrvBbNEpPNSxRrcrsKEekNzkeZD59KNgz9GH2F5cziGb
         8B7U+pL9brjPgQXIf475eXYPbBzsXlMJe2rAA51BP6b4CNlH+PIBGmbMjSVNuXRikDDC
         JtotzRwtp6XXnUOZa/GXofQBZrgGDR/SrWwicZ9XJZR+HtsIhpIRscpKFk4lN71WNvRJ
         H9jfrUg4K+i9hHxUmPcUYnYf0w0OU6HzuvIqCddLldYr5bYaYfvHibvI3yrFagCV83O2
         /FUnAK8vpdNg8uKNuWqSWlPJ1Q6FA5vLSj3aU3E+Of2tEWm4VAsmHKkKlI4B6X+bEDRI
         KGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701572304; x=1702177104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5PSqWkt2q0NsH/cezKyOksOI/ZTMxsuCeNKgtqCwp4=;
        b=JIS/4VUes6zXQW02mTEjXBMJQpxi1ZG6MqWTJVCvjVarxzdGHw33qnOX2lqNmKrrfj
         /7FgJpbKexptEhenZ469BWgzQe6FKMk4S84Znwu92nXyKoc6y98esHta0Q7knxzHvYCK
         DcygvqDY4C+99xzO1UevdP/cFtIAnAS5tTQ0Llq5nckqwEODUWmEGbAI1re0OCTyopmc
         mrSLsBKtAQtGBD+n3QjB1E/PuVSvewZMaOjd7tWroBc04BLYJv+HALUrgF6mitOCmeLR
         LFFw3uF+i2343K3UzmgGg22F437i1kuR4+hIzSM7PhXwzSIyRVFibo4vhRoENg3Yzs4U
         12PQ==
X-Gm-Message-State: AOJu0YyipjGTGjuWITuwLSoZpkwWd3uwbw773WG5dxWLtO0W/MqMbd00
	n+Qbeh9lff/m2djFPYNsJwPhJFPAhLTgseOgF7E=
X-Google-Smtp-Source: AGHT+IGpy+kyg7zdSUt8ZIPTYQVME98QFsfW9NcfwJPt7t+dpmTY/f9S3nLmw5jJawR9RxGQzVUJoIJXqhlpvLHOotE=
X-Received: by 2002:ac8:6b0c:0:b0:423:9cca:66af with SMTP id
 w12-20020ac86b0c000000b004239cca66afmr25529314qts.63.1701572304083; Sat, 02
 Dec 2023 18:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201094636.19770-1-laoar.shao@gmail.com> <20231201094636.19770-4-laoar.shao@gmail.com>
 <20231201205039.GB109168@mail.hallyn.com>
In-Reply-To: <20231201205039.GB109168@mail.hallyn.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 3 Dec 2023 10:57:47 +0800
Message-ID: <CALOAHbDYg=Oi9BEiAiGaG+Qj3WQ27Ef4=Ox8i6vHwucGFpmARw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm, security: Fix missed security_task_movememory()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	omosnace@redhat.com, mhocko@suse.com, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 4:50=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> w=
rote:
>
> On Fri, Dec 01, 2023 at 09:46:32AM +0000, Yafang Shao wrote:
> > Considering that MPOL_F_NUMA_BALANCING or  mbind(2) using either
> > MPOL_MF_MOVE or MPOL_MF_MOVE_ALL are capable of memory movement, it's
> > essential to include security_task_movememory() to cover this
> > functionality as well. It was identified during a code review.
>
> Hm - this doesn't have any bad side effects for you when using selinux?
> The selinux_task_movememory() hook checks for PROCESS__SETSCHED privs.
> The two existing security_task_movememory() calls are in cases where we
> expect the caller to be affecting another task identified by pid, so
> that makes sense.  Is an MPOL_MV_MOVE to move your own pages actually
> analogous to that?
>
> Much like the concern you mentioned in your intro about requiring
> CAP_SYS_NICE and thereby expanding its use, it seems that here you
> will be regressing some mbind users unless the granting of PROCESS__SETSC=
HED
> is widened.

Ah, it appears that this change might lead to regression. I overlooked
its association with the PROCESS__SETSCHED privilege. I'll exclude
this patch from the upcoming version.
Thanks for your review.

--=20
Regards
Yafang

