Return-Path: <bpf+bounces-14076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE47E063A
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB420B21462
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FC1C6AE;
	Fri,  3 Nov 2023 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XcEcBB1q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D341C69B
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:17:14 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2EF18B
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 09:17:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so30877651fa.0
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1699028228; x=1699633028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvmhYmC/QbC7oGEFnKNnhecSmVQk2QJI2kNmzL6pHrc=;
        b=XcEcBB1qMCVLeTU1P/QbGU585BqdFMB10sMyximesPBJR5glcQyPm0tzYbDQ4Y4nZR
         9ssWFi2xxH6f8LqvS285NOc/JW/aj2rSNzRZ8oxg81rxVjRefjYYQRm+HTfE3HypFjDn
         heST+cASc/aQlYO/yxvz+vrhN7ICT7iVprGhR8Emg5VPxCaXd8nXUC8+vb/b8k13LlLq
         kocSro5axgKeJNRbPcuQtVk0U9DvmjOKP76zAhnXo7IrTdiLVXek4S2916bFNSL989eR
         Ij3Uv6DIh3i2xgWfPvraQIzA1eagWZKrfRKVXh3rVNiLiLLoFecLNug94Ct6Jc/0H71q
         J0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028228; x=1699633028;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvmhYmC/QbC7oGEFnKNnhecSmVQk2QJI2kNmzL6pHrc=;
        b=CEep9tuRNe4QsOXmrPQqJCxSVZ2jqmr5S9OG7b1z0eoso/VbavMuGqUWxfuxOCYv9k
         sxXet/ZueRBwr249JCLRObu+koIHGlvyuZCXpyhV6brg6nnaTXZElH0UWnMreL8yye+/
         cMYyktr1K4HNdOzKtpNS46Vac9U2TUQ1CxpYTpqDYp99UzrEmV9oY8S2ZM4opuAhbop0
         oFlcS5gMWSbcoaQtmh72sSkQPQ3QxV8EimxC1xAyrOvWRebEKj8eAlkKZwumtIvXo86C
         5xxlui2Z3RF+ddUQD+G0mj3C6oY+hUWxP6D5NcYNXbRlAB+X/YVj0F+pTo2fo+F800Nx
         ZheA==
X-Gm-Message-State: AOJu0YwawiFWAkOqpRSW4AgfTkM9PO2mEMVEOhCBjsQanLz9H3fXN0bu
	Tk/+hwbB9JuZR7+UYAHAVbAjWw==
X-Google-Smtp-Source: AGHT+IEaPofX1b/aGl3GBnYi8tDM/yoFU7InvWgNuWPGwEzpVfu8963R7oC4qeAXhh5fumtEIIFCdw==
X-Received: by 2002:a2e:8217:0:b0:2c5:1eb6:bd1e with SMTP id w23-20020a2e8217000000b002c51eb6bd1emr16584966ljg.43.1699028228352;
        Fri, 03 Nov 2023 09:17:08 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8011:e80c:0:bcb3:c564:df72:fc94])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b0040641a9d49bsm3022293wmb.17.2023.11.03.09.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:17:07 -0700 (PDT)
Date: Fri, 03 Nov 2023 16:17:07 +0000
From: Quentin Monnet <quentin@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>, Artem Savkov <asavkov@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
CC: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH bpf-next] bpftool: fix prog object type in manpage
User-Agent: K-9 Mail for Android
In-Reply-To: <a115f76f-f53c-42c0-918a-b88d34c3f54e@linux.dev>
References: <20231103081126.170034-1-asavkov@redhat.com> <a115f76f-f53c-42c0-918a-b88d34c3f54e@linux.dev>
Message-ID: <5E56CB57-0162-4402-93E1-917635E68458@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 3 November 2023 15:34:05 GMT, Yonghong Song <yonghong=2Esong@linux=2Ede=
v> wrote:
>
>On 11/3/23 1:11 AM, Artem Savkov wrote:
>> bpftool's man page lists "program" as one of possible values for OBJECT=
,
>> while in fact bpftool accepts "prog" instead=2E
>>=20
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat=2Ecom>
>> Signed-off-by: Artem Savkov <asavkov@redhat=2Ecom>
>
>
>Acked-by: Yonghong Song <yonghong=2Esong@linux=2Edev>
>

Acked-by: Quentin Monnet <quentin@isovalent=2Ecom>

Thanks!

