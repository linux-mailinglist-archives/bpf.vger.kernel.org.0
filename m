Return-Path: <bpf+bounces-5620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E98F75CA32
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4031282340
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869427F24;
	Fri, 21 Jul 2023 14:37:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E551DDE7
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:37:35 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D11710
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:37:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9936b3d0286so321175666b.0
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689950251; x=1690555051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOLceJdmZjVccNbb2nj2ibCXQEfpBWAoSO8sAmi9c8M=;
        b=DJwtb4ZWgnp7VIGznz3E7/UYa5pONWuvHsf6cO1ZZBtuh9CqPjSi3nsonf1rSn9iCn
         HybM6FBVd/qZMNhf/0Iaq5jI0hxKGEwBEkkjARAhZf17t6UJVxS689956xNuhnmx+nIU
         7jjmsyy+0A/DM0VepnDYoY4k65h/MHfz3Ko3rTh+VWpH/pbSv8Sw2eXj00UQ2ztyxVW0
         Tgevqo0Ydc8yzxYVYZUaFSkMFzxmcr2d9QGdEUzrayEYmCWbCeDpfX/n8ghDop6GOrQY
         T/ZIDz9i3CZyIUKDZ/8z5UhkKE+vHissdM6FJHSoteStKjcXGcKlg8AXFo+tMViCZsBz
         isbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950251; x=1690555051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOLceJdmZjVccNbb2nj2ibCXQEfpBWAoSO8sAmi9c8M=;
        b=Q8YCtkwA7j124X5O2qnr3DLWVf4m2SKcTNPjYRCiWAff5eRumc9QdOT6y0NLNH6sY2
         s6VvB/0oPcNkg1tqx3iLZZLPv0ddbhCoUPug9TIbhd7BfNyanQJSKlZe6o3D0mtxXEsS
         kW+69mgXc0QGNRlDjLvWht7vztda2ZJNB/oFSM6Z1ggAcF55206ovtepxJlEGH/Z5g0p
         3OPkQ4pKGuJj6G1+AlchU/AHoGOM7pzUbTzSj+skcaF/lWN+zqCRNAoIkPN+4hCQ+Bdb
         qsX9xR867rvSW6Nf07/mVFD73tcJhswCtVskbu6yZZhA0iKLk7i1iImhto70D90L9yfA
         GMWw==
X-Gm-Message-State: ABy/qLZSjUgaNQ32PZGvATXh3OIYwLi5ecu0LdI27XvzDy7CgvWf41c4
	DgtF19BzljZDdoVq7esGuUjRcJGgEjxROlgxM1w=
X-Google-Smtp-Source: APBJJlGD6S3kjcxugnLx7RTmaMg1N+G4jctCJIca10RMoMXWJrhCSiZvOJlAcG/heDu34bIYXIKtQA==
X-Received: by 2002:a17:906:538a:b0:997:caf0:9945 with SMTP id g10-20020a170906538a00b00997caf09945mr1661920ejo.12.1689950251239;
        Fri, 21 Jul 2023 07:37:31 -0700 (PDT)
Received: from [192.168.245.158] ([109.190.253.14])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709064acf00b00992025654c4sm2226730ejt.182.2023.07.21.07.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:37:30 -0700 (PDT)
Message-ID: <1ea8511c-e860-bd2c-3c1e-51ab16314530@isovalent.com>
Date: Fri, 21 Jul 2023 15:36:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v3 08/17] bpf: Add kernel/bpftool asm support for
 new instructions
Content-Language: en-GB
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000147.105988-1-yhs@fb.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230720000147.105988-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-07-19 17:01 UTC-0700 ~ Yonghong Song <yhs@fb.com>
> Add asm support for new instructions so kernel verifier and bpftool
> xlated insn dumps can have proper asm syntax for new instructions.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

