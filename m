Return-Path: <bpf+bounces-39705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EC9764C4
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADC1C22BAF
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942018FDBA;
	Thu, 12 Sep 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrfuSorH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253F18B49C;
	Thu, 12 Sep 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130664; cv=none; b=H18uQb4KsArtvA0MKLpSDa8QRfibW//ucQRCjVDYIR6KL3dCRb23a27m64849FYy8r3MxRZVqFzSl5YgzHEmZjawUk9Nk4ZBnlqxCbDty6K2AEpKfuEfo7/sZl3yKfTLLi5nzok8lzZ6/DyEw5GcDZnRX0jBoPpVDL5H0U5K0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130664; c=relaxed/simple;
	bh=VQjosUghJOaOzKlqWeYd555PkuimuuK42yzjskD7nGw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WpixtdNgiWBfw4lux1H8c00XFy2Fas8jnPA9h1nQ03V3yZNP8v2QB7eAaVgCj3Oq/TLnSQevEgA9eAa0GAVIeLYkVOGHJrflNDAx5da1jCGcbtZ0sHU30ijK5KvlkE19ZO9TSwiEemmWaVs1Bs0iBbG790ColoEUQyxIDiOXD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrfuSorH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso5433745e9.2;
        Thu, 12 Sep 2024 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726130661; x=1726735461; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68iFw7qYbVcyQDFf0RiRp4aVHspyENI9JwXtbOUMCEU=;
        b=MrfuSorHHfW8BsoRqrVl7iq27soc4+eb5d7p5aX6fPvcIB6q7XXHdBVG1KwhBM4ip2
         yauIhc+JVDGgRw4Iwx9Y+qeYcqSVaXiRUHnhUdKOymw06mGDC9Z2bNs5QwGwpJM4iSjr
         W7NVz647RX4W+Q7LQwyz03wkiCaQoLGA/MTL+KRHjCdwGFmeZgrsjXSZbwzHXWMS6dD8
         EAwskJ3h4t4m3t7S0Zt8pQGpys9wRKAW7foZhkZWGdFSJyXul8/UjCdDJ17LOoK/P3xd
         bfGOk6Q7WcCV4BJ502CYEzbCD/7ynk12vyDdymsxBB7bZnRkrgk3yJQwhGs5twDLQGBK
         qIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726130661; x=1726735461;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68iFw7qYbVcyQDFf0RiRp4aVHspyENI9JwXtbOUMCEU=;
        b=Ln+lMykBbCKKfKAkADkz9weHuZZ8vvYDgAMb9Y2dIaIGuN0hB/PCY7MwtfYNZEI/2J
         yvOK6s3BwOrGZq02LAdxY4qxPFsCQHTzhDPKA6I95gclfi356G/EUJgMBSqdud3K6vBa
         Aqv2Yc+av5Wb24hb5ZWgjU4daTeulNAYR2sye71MEepDFfaobzeAwP2KOIQMWZTNGFgP
         T2efETgIswdjEUnPzd+ho/RwqUJAdP2s0kEqUFdsEMMfGmpRSLKzN1aK6zLiCQQCrvvU
         gW7P4lskQPr1O4YyPh5qTqGdciyaI/XFT5R3skzm7HD0ICybnFnLrVxolI/ZMJkoSzJ9
         lH9w==
X-Forwarded-Encrypted: i=1; AJvYcCXmE2MClLSxttKhHAOZNBl0Fy4wdB34rEYXqE0vFZgKUgJGeSCrXBLvX6Ki2UtDGCbHwiAuojJ7ihU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhwGLhM0nBy/O9YkQHpopyMy/jvLKdszZKhexscFLjJCS7wbS
	1buoRSMQCNFRFkiTiYpAcDInYgrB3CJdRlDuE56V2MW2KpcP+EdM
X-Google-Smtp-Source: AGHT+IGHOE8+b3ktBnz86gdkaQRKCSOaWTtdlUG8s3gIujKKl4tyjvENOzca2qmC88bpEsecCXoFRg==
X-Received: by 2002:a5d:6291:0:b0:374:c481:3f7 with SMTP id ffacd0b85a97d-378c2cd5ed9mr1218710f8f.6.1726130660527;
        Thu, 12 Sep 2024 01:44:20 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c4fd:1041:7607:289c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8a98sm13735410f8f.117.2024.09.12.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:44:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,  linux-doc@vger.kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v1] docs/bpf: Add missing BPF program types to
 docs
In-Reply-To: <CAEf4Bzbo=vNwn329eBcX5oqYmQBq1DxcxubFk4D6HQmXHRFD7w@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 11 Sep 2024 13:44:17 -0700")
Date: Thu, 12 Sep 2024 09:43:56 +0100
Message-ID: <m21q1pb6sz.fsf@gmail.com>
References: <20240911145908.34680-1-donald.hunter@gmail.com>
	<CAEf4Bzbo=vNwn329eBcX5oqYmQBq1DxcxubFk4D6HQmXHRFD7w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> +.. [#struct_ops] The ``struct_ops`` attach format is ``struct_ops[.s]/<name>``, but name appears
>> +                 to be ignored. The attachments are defined in a struct initializer that is
>> +                 tagged with ``SEC(".struct_ops[.link]")``.
>
> libbpf will happily accept just SEC("struct_ops"). So it would be more
> correct to say that "struct_ops[.s]/<name>" is accepted, but name is
> ignored. But other than that, just SEC("struct_ops") probably makes
> most sense.

I'll reword to recommend SEC("struct_ops"), thanks!

