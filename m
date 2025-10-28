Return-Path: <bpf+bounces-72497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92CC12F91
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 06:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDEC4353052
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D32D2499;
	Tue, 28 Oct 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bBgshXTU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219829827E
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629647; cv=none; b=HkXFqT9tcJIr9bpbp6DkU386HRdDnhz/sE7bGmrvVPUzXdXEMJyNUZG+/5pnf9+h1GLJLHtCFD/BkV9HATGU4/YVlQhBd88uasRyR06A49bL3xoPnsLYKyerCvgxWrgORgIGZ7XTL8p/j981eM1DJXfbIJf3aD1dlYTsSO4OXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629647; c=relaxed/simple;
	bh=UX3h0Pes41IJIATGA34ZfcGcoxGHwBRZyrCwKR+AqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kB3lbHvQVGLPg+MaWa5KM7cIvebPJLCFzciX2+0GTloLCxeqhH6KfdCxYz2J59hPuO8Dge+YEM70BVLftEmnJ6GzPlRXCBFYO6k434tcJNU7sZo+1TflqzOWU7OGl+i4xiYWw0rzBB4t0ZFYd6RbbkjGMR0Os3Vz22E1ANxGohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBgshXTU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d402422c2so1296426966b.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629643; x=1762234443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=bBgshXTUSZSa8iGJGyo4g0iefNe4uN4gOLC28dAwGqfDx/VOI896zXE7Av20WmJ53n
         9MRj47BQIxXQAbNkhhf5bjGe3/Ita7BQpu2FbmszHueGI6H3lnQlPdc9AFdeyVwgFJgn
         zR0vJqEheiHP+5on8yPNNq8GabK8BSwJ16WkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629643; x=1762234443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=VpHwCgbWBzOSqC5Ru14AE2frReF6UrK5KB++WbX6+DgEifr9w2r01VGuERuVI0Gwxd
         HkovoZrcSYQuFPQ3o2Kw6hAbalr2hgRs2M2t25gSp9+fuqxkkSjwatGv5azqitstUBFV
         zVTQaTiWb1JxO2MJcRqh8LlhLWqx/kghEVzdSGL7Xumx4Ocurs4GKYX9EZfxX4YGdIZd
         pKxNZrdCVJFBJYYJEJUboGAvJCBt2L1jtiHJg6DyjOOocXwYj3thFfHrTIJFowzwy6oo
         G4pvNtaeaV3zIisNp5RrryoWuz5VCe5Lau1zLN6E8Mu7OCJG9FT4EbyEDjL3M2QfM4td
         yxXw==
X-Forwarded-Encrypted: i=1; AJvYcCX8hGIAH21T2Ddy39iEAyGeJCFGcI8cG8JzgDQhaXAMBONclcdK1JqcCOxulUBIpd/8dgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVIOyH/Y7XCQfPTN2PBDChp8S0ZaOS2CB508di4cmcAwj7UjO
	LwRFlKlRajgkV5l0ng5iZ65/HJF68zrg+0N4Wd7wcGtAlyfwURzou+b5FcVVxCXGyBSEpjy5+J8
	ptaMc2vy4dg==
X-Gm-Gg: ASbGncuW/IJXTKY5HWjrPPuZ6+Agl9W4ba6/m5JyicdLRK05SFuB4y7yoBRp6f3akWD
	OlpUecgnNY0a75H2Fm86Ce5Us1Njy0thmAPMR9Kj4f+7BBhiFdwjNXWr2lfT6W/lCLqNo7l5vrV
	5ncV2oZO8zSJdCkPMCl0nHbuHdrafa3TimsZg527liXLg14thVvEtHSUshoDCD7lWG1wpyznOFJ
	cp1VEN2K///k8QdcFJKIkD9zxJNpgXuVcvagx0SVpKz4sccnmnM/J6qBFFOLYjSHg2+feY9U1Sc
	pOmR/U+SZBPIst3DBRjP9F7hN8WEXyukkuWJt4Kthp9XiVL1jNMmzuGVDucWed+pDYx+EdJEO9J
	no0ccL+vU7SubR/mifslAN5ZiQ2CDjox6i4HTo96SWjEqS148rpUU2SMJCx+Ssn9XXgABNYSOae
	T4INDvD0NyIyOZ1i9zZWz01topp8ZclxzvGVv5YjFQguTftwr0Ac2Jv7F/3p4E
X-Google-Smtp-Source: AGHT+IFunDsi0c47u8NOXiTOAN/Cy1fitzAjdKOXX6+9umMRIEEltHmxzNkBRoshevPN9zB5eOIDWw==
X-Received: by 2002:a17:907:6d04:b0:b6d:7742:c20c with SMTP id a640c23a62f3a-b6dba56a8efmr250606066b.36.1761629643059;
        Mon, 27 Oct 2025 22:34:03 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cbbsm994868366b.4.2025.10.27.22.34.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso2397170a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjX8L6/FRWPFlDxRmCQrSKNgMC++Cm//A2htlIPTmVAQRpiNZeQUs6FGDyFbtuvSky11Y=@vger.kernel.org
X-Received: by 2002:a05:6402:2681:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-63ed848cba3mr2102592a12.6.1761629641674; Mon, 27 Oct 2025
 22:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
X-Gm-Features: AWmQ_bkfyF7pn4e6fUY7bNVBhf2DrgjCvQYqt5ZlzergSjGB0BKOD2LLrniXl7E
Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 17:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
> marking those "leaked" dentries.  Having it set claims responsibility
> for +1 in refcount.
>
> The end result this series is aiming for: [...]

The series looks sane to me. Nothing made me really react negatively.
But that's just from reading the patches: I didn't apply them or -
shudder - test any of them.

            Linus

