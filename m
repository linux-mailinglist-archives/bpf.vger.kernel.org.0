Return-Path: <bpf+bounces-4291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F021774A378
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272831C202CD
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D9C14E;
	Thu,  6 Jul 2023 17:53:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1172BE7F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:53:43 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2F1994
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:53:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso639827b3a.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688666022; x=1691258022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oxUyU6YQSnWGVrIUn8qRopFoq6Rch2uU+VtdwbFIhns=;
        b=OtIAcuPPjgPdGZXTvOG+dp8Ncf1wNHAKnyOgf8otsX/2HkCf3dh4iX9/mKeMkcTEjH
         HotEuUFH81Q3W52A9glUAjAnahmFOvh5Q0OI4UtuTYtEt3VksYAjLhVNXbUGU8mNXuG/
         CR665sWy15+BcyKmvQ+ttemovQLI+nDDwu0ArIePAFzc2h84NDhlrK0Ylx/86+cGTpJF
         X8w5I90I55STIqbSyvcmCk1Pj1kt7i6Gc21G6z74Br9oU/pFlCO1TlnSytuDb+G2S4Tu
         6JUTuabnaaOPIIlA2miPiZUvi6mjqKBIBUx0JhD0ex8miQZjfkITyxJOmTijslDDhbG9
         Xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666022; x=1691258022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxUyU6YQSnWGVrIUn8qRopFoq6Rch2uU+VtdwbFIhns=;
        b=QZm5TJ/vQTUXDt2wTTno0su9DvmRs/sh29fSrjBo58htEgIp5zfkCXMhrjLQA7Rj9U
         rOjQLx4wMR3z8dIUHUZTv/lS5p+auMhLiaaxxbam74wlApVe7cd+P0lilg35QELZJoS5
         2a5BPOpBuggfsyT8/gRGdKToHu+Rn1yB8GKmx9w9oego9hBlYNbNFRKyEgef3yvfo7EJ
         GIQqc1bEGn1+ZN08u9Y+RmjrGCrdQSs7ortUvi118XMRI7FmeQDJkJT566ly+2fhkAHR
         wsHXoJB+A5gLDQO22CENINHdNQJJ1c7ZQYZphvP7HiRrVijMTZjH0XmfFHPwjo2Ay6IL
         Ezdw==
X-Gm-Message-State: ABy/qLZ++EXFsAq9Sl5pRuemI+/cuoj+Qlqoe3qBdXI1/8GWCDlYaG8p
	hx/xrg94k6brAx5y/tXLXkY=
X-Google-Smtp-Source: APBJJlFE5BxdI/XAivusUMplbfCjkAiL3p1bmMz1xra8CUVNiTbBEwhLMFoNw+9e7Fxkyx5p6WUNpQ==
X-Received: by 2002:aa7:8892:0:b0:668:7744:10f5 with SMTP id z18-20020aa78892000000b00668774410f5mr2338629pfe.10.1688666021922;
        Thu, 06 Jul 2023 10:53:41 -0700 (PDT)
Received: from iphone-b61117dec01e.dhcp.thefacebook.com ([2620:10d:c090:500::5:e96a])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b0067aea93af40sm1564733pff.2.2023.07.06.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:53:41 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:53:38 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [RFC bpf-next v3 0/8] BPF 'force to MPTCP'
Message-ID: <20230706175338.spgjlarowmbeof76@iphone-b61117dec01e.dhcp.thefacebook.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:19:39PM +0800, Geliang Tang wrote:
> 
> v3:
>  - patch 8: char cmd[128]; -> char cmd[256];
>  Fix build selftests errors:
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:218:2: note: ‘snprintf’ output between 98 and 129 bytes into a destination of size 128
> 
> v2:
> 
>  - Fix build selftests errors reported by CI:
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

3 patch bombs in one day?
If your RFC tag means 'request for comments' then please wait for comments before spamming again.

