Return-Path: <bpf+bounces-15270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6827EF921
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818B728194D
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B16C45C1E;
	Fri, 17 Nov 2023 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PngUa38v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF32B6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:04:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5094cb3a036so3604198e87.2
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700255038; x=1700859838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=amVmXfwkOYqTgQXGKycQnjIN45Ln25B4uP+vv0+ib1E=;
        b=PngUa38vQkFDPRq+5xXxowcc0KA5uz7sT11DTl+J0z7ZGYvrtyTLWIlTRjdk70mWXK
         l2Rf1USG8/4akTaAmwibrhOhuCOpbotKzrbjWwb1kszmdQB31/uzogqIfodx9YgtVMUM
         gSAZDJZn/xnSDFgKOfL/QHTG5zOcPe0M22dJ7VoPSDPkaoK92R+keOopAef1YIxoKkUE
         NL7ACB6AaYZc6aPKGKmfbp6J3sDzA5sAwG1NS15ZEFoKbEshVzVjMIlKPsXXrkVBtET8
         /0UegtufWMFecwmRcqdc+JllN1/6Tf7tkq61/LJ3AxthyCgR8JoVBhiMEtrjXVEE3Xkd
         waHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255038; x=1700859838;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amVmXfwkOYqTgQXGKycQnjIN45Ln25B4uP+vv0+ib1E=;
        b=h1a9nWkob4/2gsvFtmvwI2RYT0W6B4TLXTXTQ/GQ+/GeTuCn1Ekqd4+1ZHqnAcMEJT
         w4uV3Omb6eD+oSFohqNv8Hxng7WdeKnLwDrnF2tKiD0AZ5YMFpXQyIxWaxxALu5beef6
         F3Cxh7C1Pm5DVvBtwuQRN+IeRHIguaIMUamessFr07XLZFAfW4yDg2inGgsF0jL5wfSM
         MdW/pxpxVrJU5xlKETvi+M5oN2blDUd8QQiruL+xKiZayBTgeivAgJxn1E93r0JQ9K75
         PI4zV9226Qo0SDX8ZzyyHm7QvF5QPhEg5HSx5xFMRt4/CQdagBkcKCoMmhlgEuy0GQML
         wCtg==
X-Gm-Message-State: AOJu0YzsN+2Dkym9nfUnYKi4aZ0Qh0dNvGQ8Y0TqEUCoYJDQPj5hp9P1
	0kEFiUdK3wSO6vBnLzDTnDRAaYDpAqY=
X-Google-Smtp-Source: AGHT+IHSgfod8rEe1Vu9jMLWQU8750H44bv3PEMs5RfocuxmcIsb1bBUgjhf82USD/4v4rilEG3Dlw==
X-Received: by 2002:a05:6512:4809:b0:507:9702:8e09 with SMTP id eo9-20020a056512480900b0050797028e09mr533563lfb.2.1700255038055;
        Fri, 17 Nov 2023 13:03:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d6d3000000b0054351b5a768sm1060315edr.82.2023.11.17.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:03:57 -0800 (PST)
Message-ID: <c51c288701af8e715cac378551373aaa9fead21c.camel@gmail.com>
Subject: Re: [PATCH bpf 06/12] bpf: verify callbacks as if they are called
 unknown number of times
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 23:03:56 +0200
In-Reply-To: <CAEf4BzZKFj_kP-CkH-T=Eu0iazVGBTVA6YYrCrABYDmKnOum8Q@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-7-eddyz87@gmail.com>
	 <CAEf4BzZCdYvjj_xoBsdTwoT33Q2gBJLfGRTPcsv3bDusf9cgJA@mail.gmail.com>
	 <8625aa3eef7af265a25c4c02c6152aaefd99d230.camel@gmail.com>
	 <CAEf4BzZKFj_kP-CkH-T=Eu0iazVGBTVA6YYrCrABYDmKnOum8Q@mail.gmail.com>
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

On Fri, 2023-11-17 at 15:27 -0500, Andrii Nakryiko wrote:
[...]
> > > you are right that r0 returned from bpf_loop is not r0 returned from
> > > bpf_loop's callback, but we still have to go through callback
> > > instructions, right?
> >=20
> > Should we? We are looking to make r0 precise, but what are the rules
> > for propagating that across callback boundary?
>=20
> rules are that r0 in parent frame stays marked as precise, then when
> we go into child (subprog) frame, we clear r0 *for that frame*,
[...]
> So I assume this is the case where bpf_loop callback is not executed
> at all, right? What I'm asking is to keep log expectation where
> callback *is* executed once, so that we can validate that r0 in the
> caller is not propagated to callback through callback_calling helpers
> (like bpf_loop).

I see, I'll extend the __msg matching sequence.

I'll also extend matching in the following two tests:
- parent_callee_saved_reg_precise_with_callback
- parent_stack_slot_precise_with_callback

To check that r6-r9 and fp[*] precision is propagated through callback body=
.
=20


