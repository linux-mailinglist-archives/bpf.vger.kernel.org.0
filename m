Return-Path: <bpf+bounces-16018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD707FAFB3
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3031C20B1F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967511C3B;
	Tue, 28 Nov 2023 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4AfpQ2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D1EE6
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:43:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00a9c6f283so658038966b.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701135786; x=1701740586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sp/FOQwAgfniTsBXL9k5fwY1c2FUeLkn8p7y89WvO44=;
        b=M4AfpQ2iXPq8IyA1q+VLjpqpxwN64nD4SudqshwtmcbW/QODafkKdDQG4RhFthd8dQ
         CsTN5jUvAzErmdePQ4qZCumI0zplUfVs7sJ17uYqzdj6ii3076JPBJaoYf6483/pJMQ+
         Z5904c/0JOnuXHPjJv6C2zytGPVwxYTjL/ZBqcS4AQ/t/OM2ky6dSGZCoaVEWXVSSovk
         kAtKOIuMJ/z/kbdEbYLfmub89Tb7qOOM14d6CYXACgcMvVSv4yTa7/qOz7CuxoYgs+sr
         vJkijVJVLJPH7YqyOCYWPTRrhcTUuAIFNWOqV6NFcMiuU7fmqjaHXC2ahwLvWKtV9CMi
         DA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701135786; x=1701740586;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sp/FOQwAgfniTsBXL9k5fwY1c2FUeLkn8p7y89WvO44=;
        b=wmSasXdsIsjoSE6uSzkWPfD2xPef5DeBw4MrphPxVUwYvU4IlaCXPf2LNqNPuUsq3l
         v421CGZ97sijOom7oXbgFqca62xpN7cxl58wXaah/qUsglcBWLsmebCyHo+Gt10zlARQ
         q/cO5zexb1X7Nk+eEVN+F5lgZsqdXATqvSP31HpgbcYA7D1Kes55E7P1neIAwn9JLCB1
         RlWFJzxyFD8U/OyMeC7TNIgVuNCZ7rbM+yzYDLNoYsuT9fFgioFKUBioT/eHBWbvTMxL
         KFg5/CitUJsaQy05DWUMSvc4+ZNmSaTz4wEbNQ4D33nzXigB2F7MLdzlxtSgIj4+6JcY
         Y3mw==
X-Gm-Message-State: AOJu0YyMvzXx4uBQTcWTnayXNzxRB0L4EG/JopNzmvtOPdR6ldEOAcbN
	JBUScCBeCe6tPEjTSh0iIfTjuO+VwSdWQg==
X-Google-Smtp-Source: AGHT+IFiQInSYYRBjExj1WegM6d4ZRPm+cgiwd6T27m0zVVn9qmxnQ+vBOW8Pw7V80qJrb6sQRseHA==
X-Received: by 2002:a17:906:13db:b0:9e0:dcf:17d5 with SMTP id g27-20020a17090613db00b009e00dcf17d5mr9767786ejc.43.1701135786257;
        Mon, 27 Nov 2023 17:43:06 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090611d200b0099297782aa9sm6279835eja.49.2023.11.27.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:43:05 -0800 (PST)
Message-ID: <777bb7a7b2a8ceb1d8be09a3f0c0cbf3a35e03c3.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Tue, 28 Nov 2023 03:43:04 +0200
In-Reply-To: <2facccd4023ee77059fe483e0b1a21f6ef36e16e.camel@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
	 <20231126015045.1092826-2-andreimatei1@gmail.com>
	 <2facccd4023ee77059fe483e0b1a21f6ef36e16e.camel@gmail.com>
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

On Tue, 2023-11-28 at 03:33 +0200, Eduard Zingerman wrote:
> I think these changes make sense.

(Under assumption that access to uninitialized stack should be allowed,
 although I implemented the patch-set that made such behavior legal
 I still don't really like this idea).

