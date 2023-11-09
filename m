Return-Path: <bpf+bounces-14604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD27E706F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2900281180
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141623744;
	Thu,  9 Nov 2023 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxqy9z1o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A222330
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:38:13 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDDD58
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:38:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso1863584a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551491; x=1700156291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5SdUy3aAVcFWwqNenbgs6TNnCjzrQ55UwFmdRAA7W7E=;
        b=Pxqy9z1opg1OgwxmIzBN8QgNVmeBy8AArCAFguL4XqE0wUAyZbNzgsz502FZo2nsaD
         Sz2mp7DXFb4JLs8t+nKjjBuzkfNCrz2jIr/M8E29T6wkraypoOaEwt0su8VFUsjSCgwh
         5CeBx+X/4Fnm0uamH0ig8sSq4oKJUe88XmdvaadLBoZirw7yC0ItaYUrRK0Yra3MmZC4
         mlxi248XgmRmTJN+V7Qd+f6UNhoXLuhOQeOAvQNNweRBkgd5jlIM1gStJ/1tITA+P17G
         RGTnetl3gnjw9XduTgg4aQ/ZxQXZBBGrs9vTDTtTUSofuriQDJdyldwFnyLi/VHQuWSV
         SNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551491; x=1700156291;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SdUy3aAVcFWwqNenbgs6TNnCjzrQ55UwFmdRAA7W7E=;
        b=JKn/26zwWhdbSKCBgtOxJxlMgrlyyxFQYRHdlkwUwXXPWuBOc6ysunLHoZkigB3dE4
         cRNk59HSeqSo8Wb1cMYIVOxx86FgH+j/8rMu1tWQqGgDEZjd1457sFWI1CguX5uf2cuF
         gViv1p6yZAmeq8kE6oa2AQ7L+fwrPQ6FJEDfoYrbmTOL6gEOEldXUsligFI6dLn+ERWt
         Z5PwWy5CLvkUP0CjD44aPnM1Ha8EecuUxvUdlZufplTnFrUDXcUVjYwIvZsefUjxf833
         pxBUOWKXK4HIcjZ5jk4LtfxjriKVj+MpIuQNjH5O4HtsnUmFLwps95K08nSDChOES8ou
         0TNA==
X-Gm-Message-State: AOJu0YzjHmOR8T+OcccnaRXhGkWIpCb8EL0TNwgGkJE+wnKF2eS3UA/j
	jbU4FePYNfOQyPbepMpSFfprbsQe26E=
X-Google-Smtp-Source: AGHT+IE0+LI+Nug7EdDbv2m9bbwvpPb8qJkOzrBwpZsekEiO/Bn8++h4MV9etYf5Pvs+1rGaPs0xFQ==
X-Received: by 2002:a50:baa7:0:b0:53e:7f73:dfbe with SMTP id x36-20020a50baa7000000b0053e7f73dfbemr5007052ede.11.1699551491062;
        Thu, 09 Nov 2023 09:38:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q28-20020a50c35c000000b005435c317fedsm73725edb.80.2023.11.09.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:38:10 -0800 (PST)
Message-ID: <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback
 return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 19:38:09 +0200
In-Reply-To: <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-4-andrii@kernel.org>
	 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
	 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 09:32 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 9, 2023 at 7:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > > Given verifier checks actual value, r0 has to be precise, so we nee=
d to
> > > > propagate precision properly.
> > > >=20
> > > > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > I don't follow why this is necessary, could you please conjure
> > an example showing that current behavior is not safe?
> > This example could be used as a test case, as this change
> > seems to not be covered by test cases.
>=20
> We rely on callbacks to return specific value (0 or 1, for example),
> and use or might use that in kernel code. So if we rely on the
> specific value of a register, it has to be precise. Marking r0 as
> precise will have implications on other registers from which r0 was
> derived. This might have implications on state pruning and stuff. If
> r0 and its ancestors are not precise, we might erroneously assume some
> states are safe and prune them, even though they are not.

The r0 returned from bpf_loop's callback says bpf_loop to stop iteration,
bpf_loop returns the number of completed iterations. However, the return
value of bpf_loop modeled by verifier is unbounded scalar.
Same for map's for each.

I'm not sure we have callback calling functions that can expose this as a
safety issue.

[...]

