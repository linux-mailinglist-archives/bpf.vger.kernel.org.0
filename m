Return-Path: <bpf+bounces-15764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F767F65CA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 18:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728091C20FAA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8474A988;
	Thu, 23 Nov 2023 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/lGGkFI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48283D46;
	Thu, 23 Nov 2023 09:53:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507adc3381cso1430755e87.3;
        Thu, 23 Nov 2023 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700762024; x=1701366824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XheoBSpEARennjRDF6sHFfcQclS8Myv4FUTvOjL2uqY=;
        b=g/lGGkFIwvSibuSklfdNiG9Pvzy0UCbWgEe7DrOjPHSkgRhdJ15eVZZIxlWSQQNzCL
         cFpNQ/qa7DUWvtwkjXMJydmmNEX1nz/WtK0oAWGiTugg5El42i9Q0E2MKrrnbTfrdtvI
         HciwAYKYmBttfISWmI2N8ppf8RafL6QFFM9MOLlt6Jl+bUMEqFRT3+9xy4gmG4EW2igw
         7IFktotLzRhcN3q8S01bQu/jkQ+eyWiKAoWTa2vjJUaXwQaozqXSFytpQh7bPUSJ210i
         O82yKWzQUaCl35IsrYUAaGLcctf3tgKIZItx81Qveo5kChA5Uvp6IMxgbsMsE20+yLDi
         vUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762024; x=1701366824;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XheoBSpEARennjRDF6sHFfcQclS8Myv4FUTvOjL2uqY=;
        b=VpgYsxMoF/nSUCry8JQ+tBAy5OE2JLKAPigiP/lXMrHMEQrJHS4/FTIn0UXw1pJNIa
         RRLQeq7m2oPfhOjbB4lnVM8R2WneNjfXrLyxPy4CBuLfnJ/o5cCVD0JjO6P6udyi6xjY
         mAk+bRxqyH1N5zTfIsLWkT10zVX/OUGm2Q6mfbu2Kwvdz5rMRmKE9jzIBDCs1K+cH7Kv
         t/X9ptW9zRlSiZ1rgIBPjr4I716mTlbZFMRr7vmYAVyiIvVsmuz34Ck4h0wckqcX9JjZ
         vVGjJ7KxBUS77cBzLGnl7MmNv2Ev+dm4thente2CbSTcqACJlbiMAc9Fg95MugrTe9xu
         X+Pw==
X-Gm-Message-State: AOJu0YxaEEJJoCbfVlNl+dTicc1AG5q3m8cObYj6Z4/M8qVcB9SlH5YP
	zr4fshy7GJiCqCmSNDARTh4=
X-Google-Smtp-Source: AGHT+IHBIji8l7U8QsTbyp5T8oERMBsa8DqaGtbE7CVS9FO2B+0jgfCbczhnqzglT3WNVFzivGv5CA==
X-Received: by 2002:ac2:424c:0:b0:50a:a8d3:3e06 with SMTP id m12-20020ac2424c000000b0050aa8d33e06mr776lfl.42.1700762024158;
        Thu, 23 Nov 2023 09:53:44 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id q14-20020adff78e000000b0031c52e81490sm2206976wrp.72.2023.11.23.09.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 09:53:43 -0800 (PST)
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 deb.chatterjee@intel.com, anjali.singhai@intel.com, Vipin.Jain@amd.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com,
 dan.daly@intel.com, chris.sommers@keysight.com, john.andy.fingerhut@intel.com
References: <ZV3JJQirPdZpbVIC@nanopsycho>
 <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
 <ZV5I/F+b5fu58Rlg@nanopsycho>
 <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho>
 <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho>
 <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho>
 <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho>
 <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>
Date: Thu, 23 Nov 2023 17:53:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 23/11/2023 16:30, Jamal Hadi Salim wrote:
> I was hoping not to say anything but my fingers couldnt help themselves:
> So "unoffloadable" means there is a binary blob and this doesnt work
> per your design idea of how it should work?
> Not that it cant be implemented (clearly it has been implemented), it
> is just not how _you_ would implement it? All along I thought this was
> an issue with your hardware.

The kernel doesn't like to trust offload blobs from a userspace compiler,
 because it has no way to be sure that what comes out of the compiler
 matches the rules/tables/whatever it has in the SW datapath.
It's also a support nightmare because it's basically like each user
 compiling their own device firmware.  At least normally with device
 firmware the driver side is talking to something with narrow/fixed
 semantics and went through upstream review, even if the firmware side is
 still a black box.
Just to prove I'm not playing favourites: this is *also* a problem with
 eBPF offloads like Nanotubes, and I'm not convinced we have a viable
 solution yet.

The only way I can see to handle it is something analogous to proof-
 carrying code, where the kernel (driver, since the blob is likely to be
 wholly vendor-specific) can inspect the binary blob and verify somehow
 that (assuming the HW behaves according to its datasheet) it implements
 the same thing that exists in SW.
Or simplify the hardware design enough that the compiler can be small
 and tight enough to live in-kernel, but that's often impossible.

-ed

