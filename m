Return-Path: <bpf+bounces-46741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FEB9EFD84
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 21:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D2C28ABD1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01619E968;
	Thu, 12 Dec 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9srsSQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4C1422D4;
	Thu, 12 Dec 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035814; cv=none; b=gEXbiKL7wN2iHKpNDz6+W465ymqtcMrPzN5Py9JfLUYDQfQ9lUclvT+I9eYO0ruhGVMmwYF206tKSufNLFsWsacBNSbSuEajMCIhtmcUVY0wFWKIUmKxNjCLc/sjdpisQUtcXOrQ82SNJAuvPkFFwIooBez+N18KYIFcf/atys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035814; c=relaxed/simple;
	bh=vVt9xQa2C9bSymeBUDB+KYRr0O7HCgjXlrIMt5Jr1xE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SP8ehrWiw2gTV25mwAVE3akYsfU0wnmUDQNc+Zx9/WyjOcIlTViLxz8LqtSeKD3+CP2JzUKTeqGR0b8nvN6VkYzybYHhNr1j0mVhd6EcQKGHH4HCwa1bOf/1gIRG24Rl6V/UThcJ27tNXZ1F6bOEED42kW9AM5hX9WOMlVdLa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9srsSQ7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso9511695ad.1;
        Thu, 12 Dec 2024 12:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035812; x=1734640612; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYFige5tsHFxZMyzjI5KhwQjHxQ/KTWwqPFjXJN9c+c=;
        b=K9srsSQ7fRKhdlB8Oxm10PHYGEopi903O2pg3zJmBoAPTmvDiBs8pBwjeYZHi0VnWQ
         +sN1qfYW8eyF0nAfLvbCVbN09Q4i2vlFAd1G37lNd8sTWEaSbH3ZBUhpoGxOwzrvfkf2
         SXfwYIvOfi2nWtxpTCbZC/APZtjKEVk2JXMUiReYtyp2RZcBYZb6q0w/HRCVscJVadMz
         iVO9qXyJ22EiwtwJjRDO82e18vvBw4K+1Yxm//o11A8VQa/cofL4gclVhQbaTpvsLIPS
         FHg2HrFaqaPZaNTJ7O+/Qg3e/Eaqm2FVQGaXZ6sbO6EoMhHzb/eXkd06D3QjMdR/xado
         oe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035812; x=1734640612;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYFige5tsHFxZMyzjI5KhwQjHxQ/KTWwqPFjXJN9c+c=;
        b=VVrt8tLeqcG41yeSDeaCLjtki2017gx2bFmPPeVMxHybEQxdE7s2DHttLU5e/jLa5m
         IQXYd9sBP7sljL59Xcc41Jc4H/9aTvTY/txEhPJD18Cqh6r0ZjlYRhIXIueTK03pofvk
         EAgow7bUiWyP4MIHagBAb10NaI5VBvD401GMGh6HilDrjTFu6G/PA5Bc5zJAhZJr6HCT
         qWD1l9E54xbF0zHv7brTJz106nPA/XAwMACu2kwDL/OGsyFDE78KHx/zhkikw6iKbmwQ
         xHOMJRVovyS3SXSw3CM9FOA3eyUAmMVaLNmi76b90TVmtZYT8H3/wIQAAV781Ya0pVl9
         pHRg==
X-Forwarded-Encrypted: i=1; AJvYcCWZBsbbF2BF9HjNFghU31Of1PksVXdXLu+o9xPL1jf8KPoQKMAF6Q8Im0AHkkYybw3/tXGKgQl9@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfd8ovk+iyqTuxWMXpofJ+02V1DRqmJQlhqApkemGzkvnOWPO
	naZXOGgF9Lcay4NvwJXHLVOu885AupFZeLlbQ2u9QVHF5aZkIYmP
X-Gm-Gg: ASbGncuIW9zDVesPHUKqX6ao2w4I3v1JgPGPbKZCXaDCdcGQIYZMtMebeqXZw/u48XN
	UkOcDPF6302sqvuebes2Xo0FRe9GxiiY0wbGui/LNtC3gqN0BF6Di/HWd4ZI3xuUvStb3nhfRkF
	nL5BJKa9HDY7OpYRxLzk8/seIISIPgTkw9H1dH5sRJNRrC9FvFs+tX66RQivBuUW2adhee7T9eR
	wovVixZ8afzj0TD4OvJe2JASstxpsZPpfQPXRAP0P1pX/1DzZ03pw==
X-Google-Smtp-Source: AGHT+IEjrEZ8s4Kk1j8hI49/9EaxCfCnXZkThTlC4QCdlWySHtIuevvg2s+zt5Ng34FCLhGrHmZHVg==
X-Received: by 2002:a17:902:cccb:b0:216:760c:3879 with SMTP id d9443c01a7336-21892a76c7fmr1223565ad.46.1734035812143;
        Thu, 12 Dec 2024 12:36:52 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3af6ef9csm9306217a12.62.2024.12.12.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:36:51 -0800 (PST)
Message-ID: <7f1eeeac169356ba9e75af3034b9e941d771561b.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 1/2] btf_loader: support for multiple
 BTF_DECL_TAGs pointing to same tag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, yonghong.song@linux.dev, Arnaldo
 Carvalho de Melo	 <acme@kernel.org>
Date: Thu, 12 Dec 2024 12:36:47 -0800
In-Reply-To: <f76a8cfa-73e7-4978-bd25-637db5d98dc9@oracle.com>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
	 <f76a8cfa-73e7-4978-bd25-637db5d98dc9@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 20:29 +0000, Alan Maguire wrote:

[...]

> Looks good to me. I _think_ we're safe enough in assuming the tag
> ordering "bpf_kfunc bpf_fastcall" in the btf_functions.sh test, right?

For "bpf_kfunc bpf_fastcall" yes, we should be safe.
On the other hand, I don't think the below could be simplified with
this knowledge:

+	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq

Because there are situations when only "bpf_kfunc" is present
and when both "bpf_kfunc", "bpf_fastcall" are present.

[...]


