Return-Path: <bpf+bounces-17695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B2D811B7A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5941F219D3
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC056B7A;
	Wed, 13 Dec 2023 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llYzGWsq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB631CF
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:44:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso58204805e9.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489451; x=1703094251; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIoVsWQdmSLG7KhjHizfVZF0opIs+QRkJuA7CvfBxKc=;
        b=llYzGWsqUysFkziXO5bUcgBffViEUR2K1NZyI044t2XW9TTHbc513rHv/uXqV7i//p
         qxCkF0LyzLhdl9OlpZuCdXdQ9xaWZIZaVqIm1P4giB2xRWgD6BiWqcRnB5XkRFz9RseQ
         RUi2kqKzhyOxbB4AYcMM8+PQwt9P0rP47F/X8egXXP3zlv51j8121rAIfxMZE8kyMCSR
         u8dyATXybTArQaDnhKuB7g+QkWklmdn4C16eKbI1pWodPp9uPObZbi2mx0SUj+uHzJ0T
         UkOEU8MrJ1OmgAVl8v6VR4NB/5VfHT4Or0LKJi5i7HDI8KL+7kKWL0Wd693Gr6lbD2yk
         3cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489451; x=1703094251;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIoVsWQdmSLG7KhjHizfVZF0opIs+QRkJuA7CvfBxKc=;
        b=bWY1Qjff9NJuFexepPYcm5xvBqIR5pCVd3MgXucTPb1yyhfP8Dz3PH4XwHiHFVoNBu
         Hj82kMjVGD8IsqgHcBaitgXC52kAkIDmR5MXScr5Rwyofq15k/8Roza6zEVAxalmF9Wt
         3QiVChR0Buk+iByIkgtt87ByjXIW+Wl9taRWtlecDvP073wVpcHpQC3RK+fx6gIRSeBw
         Aw2gDkWgiSGfxuRQu9lkSvFyzMQ5p/tgK100/1t/FLtrZ4qYiFKmoWJ5AvVfVC6wZIDz
         JIlcRAUqB9Z4tvEJpGXPP9hXG62Ee/Kbpn6kfJiPNXWcI+a9LiIKX5P0WWBfcKXnHXTz
         yNQQ==
X-Gm-Message-State: AOJu0YygVl2siu7z7SvlpFSdUjf3qu+Fm7vDtkeL/EPdms6z3E7Ca18s
	9K0PCSE4IL/2ZlpTPbXtX9WKNEXKqKHOaA==
X-Google-Smtp-Source: AGHT+IE0tP9fSQX4VFaUt5GmfwKkcPl4tKwLabNj0eA564WOyiD+fZAQxe+ZUoPPco60P5ntW32gnw==
X-Received: by 2002:a05:600c:2802:b0:40b:5e21:dd3c with SMTP id m2-20020a05600c280200b0040b5e21dd3cmr4808244wmb.106.1702489451294;
        Wed, 13 Dec 2023 09:44:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fk10-20020a05600c0cca00b0040b3d8907fesm21676799wmb.29.2023.12.13.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:44:10 -0800 (PST)
Message-ID: <f94dd0e3404253936b7489ea9aee3a530749c633.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of
 BTF-unreliable main prog test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 13 Dec 2023 19:44:09 +0200
In-Reply-To: <20231212232535.1875938-11-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-11-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> Add a test validating that freplace'ing another main (entry) BPF program
> fails if the target BPF program doesn't have valid/expected func proto BT=
F.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I have two nitpicks, fill free to ignore.
When test is run with -vvv, verifier log says:

    -- BEGIN PROG LOAD LOG --
    func#0 @0
    Cannot replace static functions
    processed 0 insns ...
    -- END PROG LOAD LOG --

Would it be possible to match the error message in this test?
Also, maybe kernel should be tweaked to be a bit more informative,
as message about static function is confusing, wdyt?



