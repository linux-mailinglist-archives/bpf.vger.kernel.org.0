Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9E14E744
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgAaCuP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 21:50:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaCuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 21:50:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so2658033pgk.12
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tCkbwcLKPQmsrnMI8S2u+/PckohpACx7nD547iLkJY=;
        b=pr9NL1NvnNShgg0/3sh6ddG7+gj6pNpk8CGTElU83/CMVPzyK+VD2coGOaK0hl2xOU
         va0KkbKJ2GWCc5GaIP/M6471923lHtEtpffa6Gx5+BkCdu8lSEOkAdMlg7cTkdNyF/pA
         ysfwgYs639GoWRl009osld/JEin/hPFV6U5EMTBIX5MxqeHsC16FPySb9GoEGnLNWLj4
         gsYTGqUYjXbOPwWxXfe1Zp6uPHG4SbhK9TjcppkDF0r1+lLE59Aj66u8f9Zk9KhRAwgk
         ci9Wnm5M2zoSaFJ4H+PsEccj1knbf9OYMrZEIYdRE0mR6czUa8mrdxIBf4wFfVx4mvJ3
         ZsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tCkbwcLKPQmsrnMI8S2u+/PckohpACx7nD547iLkJY=;
        b=G7v0Zg6FgIieNJWZB+EFnhamKrY6qdLcq8p8Cexul11dauaA/ICkwAzMUbDYqi3x3q
         Z+TSqCROf7aIpx/DSaDqFqYsiQCmPHQD7V9DEGR/omT5CRM4is/Kv4ycvjcZXOivhJUP
         WHX+oP4tAfemSZj+HnyRDtpFYQXNzIu2swxS7kbfJS+5L42KFaFs3Oji7qpyUm6UDCpb
         D8fUZiol6Agc0qjlCEeOeI3n/hYhrNzM6RLeNXOyXpryMqXw9BHMVIuVc32YD6JqvNr4
         pXhCCkSxd5bZ1XtYlkCnh6KQnIRbULaV4pYi94MNjHZs/xKmXz4N2UfPsv9Er419eNIB
         cohA==
X-Gm-Message-State: APjAAAVRGXHSsFNWZqnX0E//XyKixUpK151e31YarVCVvjmSttOnfB+x
        F/Uq+3vxRm3xuwamWZNjmSQ=
X-Google-Smtp-Source: APXvYqxdJc8KcQ2fuE+Ctmt83ZgJBuLMY5xSVFjDJwju/9JKPEOa/xzNvaH1fqbAseCyh1aMcaWRWg==
X-Received: by 2002:a62:342:: with SMTP id 63mr8264103pfd.19.1580439012958;
        Thu, 30 Jan 2020 18:50:12 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:ace8])
        by smtp.gmail.com with ESMTPSA id 133sm8119586pfy.14.2020.01.30.18.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 18:50:12 -0800 (PST)
Date:   Thu, 30 Jan 2020 18:50:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Message-ID: <20200131025010.x4thxuxt5tlvolwj@ast-mbp>
References: <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <740b2df9-af35-cc9e-d4f9-50978ef2dbc6@fb.com>
 <5e337859a4287_43212ac192b965bc51@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e337859a4287_43212ac192b965bc51@john-XPS-13-9370.notmuch>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 30, 2020 at 04:44:09PM -0800, John Fastabend wrote:
> > 
> > But verifier seems handling <<= and >>= correctly, right?
> > Even we have it, the verifier should reach the same conclusion
> > compared to not having it, right?
> > 
> 
> No, verifier marks it unknown and doesn't track it fully. We
> can perhaps improve the verifier but the above is a nice
> fix/improvement for the backend imo regardless.

I don't see how the verifier can be taught to carry smax information after <<32
shift. The verifier has to do dst_reg->smax_value = S64_MAX.
The only way to carry smax is to recognize a sequence of <<32 s>>32.
While at it we can recognize both <<32 >>32 and <<32 s>32 as pseudo insns.
