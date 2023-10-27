Return-Path: <bpf+bounces-13509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623947DA261
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911F31C211A6
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86D3FE33;
	Fri, 27 Oct 2023 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmxAkITO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2E3FB26
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:23:20 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FA1B5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:23:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7a80a96dbso32149177b3.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441798; x=1699046598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yARJvkL89rH3jq0Z53eSfLhxtKLw7kncSliYwuuLzlM=;
        b=PmxAkITOOodKzYdgIFpVR7Ejp7NwteS75Xf8CpOAs8mvAF382VTJFz4xeol04OIDOL
         lLH8fQtkK1rxS53jQ560M5PwTgSarshTBR9JmICsCcz22grKyNnRh9gtLCOlc85VreUN
         Pf+4ogyPkA0ak6hB0/e9ure62KiXzkM4HqaATSA5Oaqn8sSgYJMB2RUfUKFNGQTsAYNl
         Ct+91nRa6hVp3ejjZokOBe4V6FBFkS9mqN3kADWjXfjUd1Ueqk1gfgCZOm/hZL2uAEJN
         4v6Ufw+qlfK0pm+PGaTG7++QZbUPJYCzJOwQ0w18K1wenCYHTxjGZSY1ka5mbBrlt5Gy
         Ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441798; x=1699046598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yARJvkL89rH3jq0Z53eSfLhxtKLw7kncSliYwuuLzlM=;
        b=D9ZRyVPr337T3xr+sUQAAX4/jt6ZZug+qOHF+S7d/hvx0CHP+nNRWheSE8X7Va8hfg
         l5x2cKyXGMMx+roVlJFz5Bfthf1lc4yfB5K/iiYy+CBg2LKOvkEGMFs5X/3mklfOCFGf
         dlre0oSQbFSW1WIJDRR9yqMPM4NAQlzY1YiVsUyKDjFNcnoA6A9djbx5nVGwLVLb6lC3
         Vl2LdXCoSWLNamIrYscn/+zat8kjSbuX4NqTU5IbVrZ9Fdt/qS7ZbHYIzqYQNhTf9UvE
         8SX7lAY8BX4S1LAir2CGxHbIm/wbV1YcdWOEolViV9/nxDcpBhvnThStlENsFkG7AheW
         wBrg==
X-Gm-Message-State: AOJu0Ywe/J21xWgNFa0CUini6y429w+PPlP+61ovX/Vra6jG38JsRyeV
	C1bnA/p1gncTt+ipFvU0AU2v/W0E+dI=
X-Google-Smtp-Source: AGHT+IFCRY/AUY75UevtbjC5NOaE2VXBSWNlFKNqVcgPkoEQJt+oxmoNnFbXCJd0GpavLwE2T3rXPw==
X-Received: by 2002:a81:9897:0:b0:5a7:bfc6:96aa with SMTP id p145-20020a819897000000b005a7bfc696aamr11851635ywg.7.1698441798264;
        Fri, 27 Oct 2023 14:23:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:41cd:a94b:292d:cd8? ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id f124-20020a0ddc82000000b005950e1bbf11sm1084298ywe.60.2023.10.27.14.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 14:23:17 -0700 (PDT)
Message-ID: <7f525126-92cd-4559-9128-894f0d9be512@gmail.com>
Date: Fri, 27 Oct 2023 14:23:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 00/10] Registrating struct_ops types from
 modules
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231027205227.855463-1-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231027205227.855463-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for sending out this thread by a mistake!
I have resent v7 as
   https://lore.kernel.org/bpf/20231027211702.1374597-1-thinker.li@gmail.com


On 10/27/23 13:52, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Given the current constraints of the current implementation,
> struct_ops cannot be registered dynamically. This presents a
> significant limitation for modules like coming fuse-bpf, which seeks
> to implement a new struct_ops type. To address this issue, a new API
> is introduced that allows the registration of new struct_ops types
> from modules.
> 
> Previously, struct_ops types were defined in bpf_struct_ops_types.h
> and collected as a static array. The new API lets callers add new
> struct_ops types dynamically. The static array has been removed and
> replaced by the per-btf struct_ops_tab.
> 

