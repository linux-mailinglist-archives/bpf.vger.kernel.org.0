Return-Path: <bpf+bounces-13317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DE77D836E
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8140A1C20F5D
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC772DF9A;
	Thu, 26 Oct 2023 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KrcaQJKF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D28F70
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:23:06 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D717AB
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 06:23:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so185839666b.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698326584; x=1698931384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfGF1wvIaczehv06ebByBZL9NMqVboZ+F6Zxo+zfw5g=;
        b=KrcaQJKF5Mx1m9EB+S/aiw6P7Peorb8BVFsrA2AZaME9cJfQ0pIrZIZtVCFd1AfHW+
         3TUQF8uBD9AzjLJYYFLVwINWmN06eg7rv+FDHCRNtwxdIK3soyyRMGUmqe/m4HQYBhrZ
         2El7bl4gGry4vri6qYozPYlRvQNOU/O40R809bDscvX/No305TzlXRYCj0cNZusC0/mm
         luVUiXC9g11JPB8sg3N3M3vt2e2n45t6T0tA7HYeqkKoCRIctpTf2iOsu9r3P7Wk7/a2
         gFG7SZUm+ym/AvkxMEkYTklRYUKY4fzAtJKKv45jSBnXa/UtTh7SioZvnbUb/VhVrFqD
         nAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326584; x=1698931384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfGF1wvIaczehv06ebByBZL9NMqVboZ+F6Zxo+zfw5g=;
        b=cuvOA723BRcfh/Obas57GMvueszPAQ+5im4ukyWrqNiWxUm9mea80DvHXacDqxDIGY
         49AwyrL7ZvX0Q5RVRxCmYFM0H5UVdahDYr4Dpn86Z1RtwAUInzlR+Jk1jgitTxteOJng
         xOT5GFEp2qT2RGGxa1+atdKeRC3R4uf01Ca/NHl1v76APpxP9mXvsbljOCR7ddvseZyB
         /Ca5tdZwuRc/80Ro3Ko9fj+YVb5crUtqB+chfqvor8be6INrVn1mSDl0R3xm7L4D3Bx2
         BTte4hG1d9OyEQcdwELiZn5848ViBqbod8D5Zh96e9JuG8+2+AZcslk6OwoIQyEaOFeb
         3yuA==
X-Gm-Message-State: AOJu0YxAYvjbJYznC2HcxCnTZfcpB/RGaPJvIVglOa26Kuo7O1YQND5u
	H11dd33BV9CPG+7wHtfWKYqaJA==
X-Google-Smtp-Source: AGHT+IFzYYXh7b6O1wp2FSPKvSqNw+ZLn8IKGWJKSb4LLePgHpa6NYbUrLvtBU5Tqmqq2ikxrz1WAw==
X-Received: by 2002:a17:907:96aa:b0:9ba:8ed:ea58 with SMTP id hd42-20020a17090796aa00b009ba08edea58mr2636546ejc.30.1698326583879;
        Thu, 26 Oct 2023 06:23:03 -0700 (PDT)
Received: from localhost (mail.hotelolsanka.cz. [194.213.219.10])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b009a1c05bd672sm11472502ejk.127.2023.10.26.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:23:03 -0700 (PDT)
Date: Thu, 26 Oct 2023 15:23:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
	kuba@kernel.org, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
	sdf@google.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
Message-ID: <ZTpoNuFuE1BYLqeB@nanopsycho>
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026094106.1505892-3-razor@blackwall.org>

Thu, Oct 26, 2023 at 11:41:06AM CEST, razor@blackwall.org wrote:
>Use netlink's NLA_POLICY_VALIDATE_FN() type for mode and primary/peer
>policy with custom validation functions to return better errors. This
>simplifies the logic a bit and relies on netlink's policy validation.
>We don't have to specify len because the type is NLA_U32 and attribute
>length is enforced by netlink.
>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

