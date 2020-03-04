Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A685B178766
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 02:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCDBGW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 20:06:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgCDBGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 20:06:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id a141so86162wme.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ctoiEBV7oYQ+Ec8vuMBepnjoi9mkX/M9Ee8Z3sCdCxE=;
        b=iPgccfS1xG4obi2LdzeZagYxTiUM5+2sjUgn03SpxHQENWRvN8ZboigVQDfXhAuwmZ
         LG85TxJex+PPxXCRpDkeZyMh0tPHllB+HZjkxzJp/RtbP4d3oS5BpJHKKH96iKC/a0ZG
         Jo4ERdUQY+Fz6m0HJ9lPq4EbJZRBNXcUGURXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ctoiEBV7oYQ+Ec8vuMBepnjoi9mkX/M9Ee8Z3sCdCxE=;
        b=bqgrgqLo3wSEnbmBw4DWnYByoOFjFLFrzxeih2d98+ttnjwe6sSsNeiUle6az7yBRy
         D4r9obUnNwij8BnslMUkH0rt2DdDodL/0ftHYQ1PkT6J/PXo+cjPUh3J1UkTKMZ9u0l4
         ykNbMidCX+OXSQmUEBQHsG8K05yJHdrq1kkXBnNb15edSMPaTK3POjOKRtvc1xlyQEA1
         V9RIhzWN5M9GSw1jeWn+eXzy+wUd7jKag4JIUDYG8SCqGX0X2AFsn0vbAp48QPs4/nj6
         b/E5leb72aRDsH4DQ/pUzMc2S53AMgUvvCBssIMeIfd6oZmZ9aYMOE6WHLd4tp6GjCrX
         gAaA==
X-Gm-Message-State: ANhLgQ1hrjZljwfF4nonY38CpS0AiNduh46fkcWBvUfrmgJRIZQn2P0j
        KRWaAuUj326Lo05Q3Aac4rBG/A==
X-Google-Smtp-Source: ADFU+vtUHPgMakUmvktqI1lex+5NQgqVTinEGb8RQekmdzSLGOf/IWuJ0DbbaCOZJ/J1wWXQzu0BYQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr367432wmi.188.1583283978996;
        Tue, 03 Mar 2020 17:06:18 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id c14sm21550977wro.36.2020.03.03.17.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:06:18 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 02:06:15 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200304010615.GA14634@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-5-kpsingh@chromium.org>
 <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
 <20200303232151.GB17103@chromium.org>
 <20200304000326.nk7jmkgxazl3umbh@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200304000326.nk7jmkgxazl3umbh@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 16:03, Alexei Starovoitov wrote:
> On Wed, Mar 04, 2020 at 12:21:51AM +0100, KP Singh wrote:
> > 
> > > > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > > +                       if (!btf_type_is_int(t)) {
> > > 
> > > Should the size of int be verified here? E.g., if some function
> > > returns u8, is that ok for BPF program to return, say, (1<<30) ?
> > 
> > Would this work?
> > 
> >        if (size != t->size) {
> >                bpf_log(log,
> >                        "size accessed = %d should be %d\n",
> >                        size, t->size);
> >                return false;
> >        }
> 
> It will cause spurious failures later when llvm optimizes
> if (ret & 0xff) into u8 load.
> I think btf_type_is_int() is enough as-is.

Okay skipping the size check.

- KP

