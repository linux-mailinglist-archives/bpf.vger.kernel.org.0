Return-Path: <bpf+bounces-12537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E17CD877
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5BB20F77
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA541182BA;
	Wed, 18 Oct 2023 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENOQr4QV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA115AFE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:44:07 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC1B0;
	Wed, 18 Oct 2023 02:44:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b6f4c118b7so3743129b3a.0;
        Wed, 18 Oct 2023 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697622246; x=1698227046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6AhLa08cOUoEIc+dFU2XZRVt7s6EJBbaKPXMdbbhl0=;
        b=ENOQr4QVSTWwG++uT0zGovqLenK3zCJbTtix2etGTrX3FDRtQNrD1uPREhnIqZJkWB
         C1oYE49qmTh9bkBXuotZYjArwGTq1Fs77bShZbFjwiz/o3pyLuCpEplef8N2yf0sDiAy
         uf2rnv9tZhHJwXjk43+Z+gEAiv8vOH4AN+pmY9FgvbUQ9SLB9squeIPP3p0lRcVr/s9V
         BcM/IWS/i+6LtTmoaSY91/F9t+MW8DK9eWBEwjbmqVYUiz3wEzgL5ZMyEdu4+uyS1nzi
         x9BgZV4FmoGvPBWjI0MHqT/89hMK04ZazBc8LkHJeSTEMg/35nTNwPUzJ8sA7Vmwhxvr
         i63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697622246; x=1698227046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6AhLa08cOUoEIc+dFU2XZRVt7s6EJBbaKPXMdbbhl0=;
        b=nvf/d6mtgrzjd5sOxvQdNFfnWlLPmbOw0fTtLKkPN9PvZdLjn30n7bHavcBO4zJ70U
         YeMPZ4eaO54Heh3L2KMIAvcauyG9ztEP5A3CuJusnGWVri9GRwUibkegT5eo/sHP1GX0
         cRAC2auWszOV3snBFHOL2vdPhmYS9hteyaeBThwa/Idf4PfzZAIme3kF5JyeZUDVjUuL
         KUpDLVOTdEly3ccilkREYX1/TybVHR8OFltJ37qRWeLsvqGOtbBHJUcgh2Y2yHcasBfh
         3Rx38ThXjDYgCLKZYIYesbFzNeVubFMVLj0nJQs3OLPa6R7ZTwAT2OLg3DlTmvehLlB1
         0Oug==
X-Gm-Message-State: AOJu0YyrypOo/jdYxMcTAqzAxG+DNHxiWb1rcDYcy5C+OlTebLW4Vkv8
	36NSBTyL3/v+btXp3B+6JJs=
X-Google-Smtp-Source: AGHT+IGUm6gTLVJDprig33l5w00MZFHs3rEPoEuX1RznjitIj3tt5NFOoc2FQFJAjx7I7S2euOKp2A==
X-Received: by 2002:a05:6a00:2483:b0:6be:22db:7a13 with SMTP id c3-20020a056a00248300b006be22db7a13mr4831657pfv.25.1697622245788;
        Wed, 18 Oct 2023 02:44:05 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id b24-20020a63d318000000b00563590be25esm1310252pgg.29.2023.10.18.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:44:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 23:44:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/9] cgroup: Add a new helper for cgroup1
 hierarchy
Message-ID: <ZS-o5K9vzmLqnLMX@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-4-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 12:45:40PM +0000, Yafang Shao wrote:
> +/**
> + * task_cgroup_id_within_hierarchy - Acquires the associated cgroup of a task
      ^
      doesn't match actual function name.

> + * within a specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by
> + * its hierarchy ID.
> + * @tsk: The target task
> + * @hierarchy_id: The ID of a cgroup1 hierarchy
> + *
> + * On success, the cgroup is returned. On failure, ERR_PTR is returned.
> + * We limit it to cgroup1 only.
> + */
> +struct cgroup *task_get_cgroup1_within_hierarchy(struct task_struct *tsk, int hierarchy_id)

Maybe we can just named it task_get_cgroup1()?

Thanks.

-- 
tejun

