Return-Path: <bpf+bounces-16329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EB7FFD03
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 21:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE91C20F68
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162052F84;
	Thu, 30 Nov 2023 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHaWi4Rt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922E10E6
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 12:45:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso1636599a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701377121; x=1701981921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kMiPQV1+/zOdCemmSBZA6su7Frp1ygAuove7+Wudso=;
        b=CHaWi4RtLQ3jp8pdJmS6/+pLUlIaZ8m15qsGIbHNgK5pBFIibhxGIlKkY8XnGrm6LO
         M0f9/U7deZ39gkKdw9lUAbH5gTsytCRqkE1AhtQXGT5gV0C4pOY8Rl3896OZ1HEgxAry
         Lj5f27BQOhnYMn4ukROVHosolk0pjd/TQ697I7jcDYmPG3QvR1kOKIdCHQwhFnLxnY+i
         28Lmop+WaPvIFx6ONkacvhdZk5U/TMx5vS4z7Kwz38u1VvWlE9bUsuDzuT2Q1eldFJIB
         /LB6JeaElkF0BoHrmi8sRpyjUVSrzIkyADpeNbanvSLowwT5J9ken2YgEY4Db22kIoxG
         IUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377121; x=1701981921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kMiPQV1+/zOdCemmSBZA6su7Frp1ygAuove7+Wudso=;
        b=hicI3SefrChelAivH4lFbjaPj8xXh9JCF9Eof7ZC00p1+pQXRUDHoPlJmNzTb3WGEf
         qdhPmtBp7KfJ5+027HlbvK3HbJPwFdnmMNpWfTOVvSd7kCWramZMWcS0IO+ZFbzkGt4L
         xOivTmTO3UVyMf+nUnBEZ2vGsM6N8Ff8U/iXpKuLwFW+Mo2eF2kJk6YhjKf7IizOJfmh
         NID8ss/MKx7hLbF393aSqDhYoTh/nmrnzIDrZuG8lLPefzGUBvygeWMHSwcC8Joyoslx
         UOQcko4rsypPBlSbeH9Z+pdGlqs7U7pe+GKgDMbrlKzjWpKBU8VKFcgjtWWh3PEREzeF
         Ti3Q==
X-Gm-Message-State: AOJu0YybvRvv2gcpR9ArqiV1HbEIxmakoEe0BmVom6MUNw73LC1pgQz5
	yKfiCrV31aFgSa56QHX5bUTnn2dSw93INQ==
X-Google-Smtp-Source: AGHT+IGN2MTosweo0E3TH94fLzBjBXX3uR0lyh1WQVHzeKQkvIWIRN2tm1L7vaQLW+xEW6RgGwd7Ng==
X-Received: by 2002:a50:c042:0:b0:54c:4837:9fe7 with SMTP id u2-20020a50c042000000b0054c48379fe7mr101893edd.62.1701377114440;
        Thu, 30 Nov 2023 12:45:14 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7dbd1000000b0054b286fa48bsm882116edt.91.2023.11.30.12.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:45:14 -0800 (PST)
Date: Thu, 30 Nov 2023 21:41:34 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231130204134.4i4tloaylxrkrnrt@erthalion.local>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
 <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
 <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>

> On Thu, Nov 30, 2023 at 12:19:31PM -0800, Song Liu wrote:
> > All in all I've decided that more elaborated approach is slightly
> > better. But if everyone in the community agrees that less
> > "defensiveness" is not an issue and verifier could be simply made less
> > restrictive, I'm fine with that. What do you think?
>
> I think the follower_cnt check is not necessary, and may cause confusions.
> For tracing programs, we are very specific on "which function(s) are we
> tracing". So I don't think circular attachment can be a real issue. Do we
> have potential use cases that make the circular attach possible?

At the moment no, nothing like that in sight. Ok, you've convinced me --
plus since nobody has yet actively mentioned that potential cycle
prevention is nice to have, I can drop follower_cnt and the
corresponding check in the verifier.

