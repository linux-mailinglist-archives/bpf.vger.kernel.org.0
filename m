Return-Path: <bpf+bounces-45619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE49D9B75
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E25283D9A
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA021D8A0B;
	Tue, 26 Nov 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cNKQrHiL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47C1CEAD0
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638656; cv=none; b=QxAI/UolvvwudKPDmPdtCYSIJmUxhDbNSXkNNekvRDhLsyAfaD+6t5pAND1Dr0lUDb4IF2GYou3qhoHiB1WZr9hQwHGBhk1C6+2ZJonMN7w/7F225eqODNSYbWeiVx0ygCy3/T3li2Lh/KvxOxi8RpUClOlTFC0AKbl8iXPcuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638656; c=relaxed/simple;
	bh=6SCq1l6xPiuKi9BEa5WMdd7lRuZGGOXVrNLtrLO+FT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnrCG0+EAa8ushtX19sJT2/vvfv+iGVt8PeqWq6JDPzgDs3R5RUEplt8MubOorTCL4TYe5SqH9ppjQC+r7slCxWHLy1GByX5jm6S1vHJgUEe511Fr1/qXPsYBrdokRSugsWbQmTHRY//n8JB6FHGsSSlxnVtSjukcoJuT9Kb/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=cNKQrHiL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa53a971480so430065166b.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732638653; x=1733243453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q6KPRo7vFpnP+9rfEZN9EUFzvorPjEIxX5AsTLymFPc=;
        b=cNKQrHiLvNRFNyGfRGXVHLUGYP3Rk+YpQag5F6GAA37BHPPtpCUvcIdkWbLXXUaZFB
         CyZCUxyUQkEUTBRPfPvof1a+76aPE9LNml1++vAq+xJh2X/CgexKQohQ9XXPQUgbIZmG
         rHeL08DmSWHM0ApefZENv7XJybUlzbfVtH/L0SW1f7Aw1ecabhmAPJWRKMNwMpcAxQmX
         kj83KUYeUBokMsLJ64dVtF5KC6gHhrICdHi4mYooY1lFGSyP2Dq3we1e+5R6x68+w/WB
         64Mv7/uE56gLqZcbpOtbYouY6+8kNOHPB4maGobcwAtpDHiyPAFVrqJTQjtb5MXMxyPJ
         L40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638653; x=1733243453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6KPRo7vFpnP+9rfEZN9EUFzvorPjEIxX5AsTLymFPc=;
        b=Hd3PMUtU9+cYf3lOfOvvS000twEgXJOnL2dxJOrzrqGtpQhtNZIy/rgRZhdWRfmopU
         RB7KROe019HMeuiHZ7B6PmHIZSKfhlAeSHx1y5aU1jKIK9VTHI5Kv7+y1Utev4L8cffH
         usUCLbKw3thClboAHEadUMclpG7Ro8x7ipSVbwnAevd4mXcvikODdoZNPvNZndaek8iU
         JaDphIBIad3g8X8CljWD3ubXIuOBogyJYxdDgRBKU1F9gofEYoM9yEv/h5bLm+JAyBK8
         sE9hyjBHiGjwH4KLguV96yurQy4ZMnqMTTFdvAsM22TMUsfCMAvfXQiqRzo5xQlIDmN8
         sXgA==
X-Gm-Message-State: AOJu0YxW/pWb1FjHB/wHyb12GcAnqDtmtjwZpymeX8D/vXj/Ng+eTL1V
	uUNOnezZxEih34T33X1ZWWcgO20S1PJhwDcN+vdmwyCU8TYvQJb7PUajZz1Cgl6tjQXWEV1gYjH
	f
X-Gm-Gg: ASbGncuAzSibs8XwWp3ZQajH6MCJ++WvXvO1m3MnLlCPdkuK0XMdBAmTUwhy9Q7bOBE
	6snqyr7cz5YCpDai5JNW/ysj4xjCDnYPyrGR2LxkNcJcYK5YTbCNoyM1flKfEOCzke2vMLk97hP
	yeGEzOc+zRCA+pvO/tlB/LdJe/+kaR2DEeHVTn9e65t3Vg6juOAq/dGEqxbJDzONYGsZUVDiV3Y
	rWvSn1VDkV6oQ1KA5u1maFRE6Py0oSSTNMHH7s=
X-Google-Smtp-Source: AGHT+IE0qJwhEK7ZSQy2qPrCzK7pE+akI+FOTBLfqLS+OpZ/++RdnV0ZWbIooEo00ErCpkuJniZA8Q==
X-Received: by 2002:a17:906:3196:b0:aa1:f9dc:f9bf with SMTP id a640c23a62f3a-aa5099065bamr1374600566b.10.1732638652387;
        Tue, 26 Nov 2024 08:30:52 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a23545dsm331322366b.152.2024.11.26.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:30:51 -0800 (PST)
Date: Tue, 26 Nov 2024 16:33:26 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: add a __btf_get_by_fd helper
Message-ID: <Z0X4VqTxbT8+NAuW@eis>
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-2-aspsk@isovalent.com>
 <CAADnVQ+MdboMD8SGyx2xSbJ3+YL2HgwKAZvj+S49G3x0gqKLXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+MdboMD8SGyx2xSbJ3+YL2HgwKAZvj+S49G3x0gqKLXw@mail.gmail.com>

On 24/11/25 05:31PM, Alexei Starovoitov wrote:
> On Tue, Nov 19, 2024 at 2:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add a new helper to get a pointer to a struct btf from a file
> > descriptor which doesn't increase a refcount.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/btf.h | 13 +++++++++++++
> >  kernel/bpf/btf.c    | 13 ++++---------
> >  2 files changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 4214e76c9168..050051a578a8 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -4,6 +4,7 @@
> >  #ifndef _LINUX_BTF_H
> >  #define _LINUX_BTF_H 1
> >
> > +#include <linux/file.h>
> >  #include <linux/types.h>
> >  #include <linux/bpfptr.h>
> >  #include <linux/bsearch.h>
> > @@ -143,6 +144,18 @@ void btf_get(struct btf *btf);
> >  void btf_put(struct btf *btf);
> >  const struct btf_header *btf_header(const struct btf *btf);
> >  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
> > +
> > +static inline struct btf *__btf_get_by_fd(struct fd f)
> > +{
> > +       if (fd_empty(f))
> > +               return ERR_PTR(-EBADF);
> > +
> > +       if (unlikely(fd_file(f)->f_op != &btf_fops))
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       return fd_file(f)->private_data;
> > +}
> 
> Maybe let's call it __btf_get() and place it next to __bpf_map_get() ?
> So names and function bodies are directly comparable?

I named it so because the corresponding helper which is taking a ref is named
btf_get_by_fd(). And btf_get() is actually increasing a refcnt. In the bpf_map
case naming is a bit different (and also not super-consistent,
bpf_map_inc/bpf_map_put to +- refcnt). Do you want me to make names more
consistent, globally?

