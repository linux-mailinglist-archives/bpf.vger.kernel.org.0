Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B62254D43
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgH0Sn7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Sn7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 14:43:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42515C061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 11:43:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z18so3103421pjr.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zGpcXGEgiuM5euqw2R33WTdizWfp1ejK+k9wT7eMkPo=;
        b=GG+9D5Aw0/vR4CzvWl9XLgFnGZB189wpPwNDP7JfbWc3Ja0+/SXAKtdqtAXHK5sEJW
         cOymzrUBD1xnkyabIkoifsh7mEcf8CK2imuG4SwMXlg/Ny5pTo30MxOcbt2pLlINrSky
         FzDOf02H0CbGSlO7c4kV0l1G604d28YCNtMOjPK4wRVHV9RuOf4aEncpJuhPDxSqcoZR
         8p3/2tNg27/pE35IxQXgw4RF+m4pxgaCUe4GrkFWf3Oq1xO4+YHHgYWZ/QQkg8ZPDEU4
         yXNgPnTkDc8TFw1dftvhc6azNo/FSbEeOY/ap9T69edg/Ebl8iTF+fDSj8OZxuvnlqv9
         jWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zGpcXGEgiuM5euqw2R33WTdizWfp1ejK+k9wT7eMkPo=;
        b=Gro4dTOlvdq2BTJUIsow6bUDfIrUKWGMs0xJHJ+p0aYFAZIdoYfichDQCYhOg8r4DZ
         qSG6UhrHD5h6PHiLAc7gFDSGCFBZ69+EO3mt7VEkOX/w3Ofarv3dd9rb2P8dVqLAK8uh
         htdGpaYo6FQ4buUBwKMpZRYtYvsLYrwriL2aXQhwUcnkh0SkSrc9lOgPXGGzGrvm4PA8
         AA/2JdyiwBwuBxIQkID73or9BDb7OEwnPFHK5JB9GfBElw9a/EyvudDNT9zvtInwlhHc
         8IKzeR9315UGyZz6BtCERw8XtuwwaCIbIggV+0wVQDzggzg5gsYY+P7UyQzUISUrXZgx
         V/Ow==
X-Gm-Message-State: AOAM533SvY0wt+vytkqmMXDYCj7JWPKvB8V6Mcc9VkVsCj9y/CVqjbPU
        FOnrLTSVJOeKgoMKO05l+xF16Cn2HYfLyQ==
X-Google-Smtp-Source: ABdhPJyiRTlRe2dGanjKojkWbuyB2LUMbEuFmqNg8JPDnIw2CbQvovXp95nVlDrgHueZL5f/ZT1kaA==
X-Received: by 2002:a17:90a:88:: with SMTP id a8mr186736pja.196.1598553838585;
        Thu, 27 Aug 2020 11:43:58 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id g33sm3039063pgg.46.2020.08.27.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:43:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:43:48 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Edward Cree <ecree@solarflare.com>
Message-ID: <5f47fee41cc8_ef1d20868@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQ+XYd=GzF2P=3RO_Xi6m5zQA2q3JYTWxbh3O=Pfn8zLXw@mail.gmail.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <20200826015836.2rlfvhoznylkabp6@ast-mbp.dhcp.thefacebook.com>
 <f2056e3c-e300-6fa0-8b8e-fa19ed5580bd@fb.com>
 <5f46dcd8c0156_50e8208f4@john-XPS-13-9370.notmuch>
 <CAADnVQ+XYd=GzF2P=3RO_Xi6m5zQA2q3JYTWxbh3O=Pfn8zLXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Wed, Aug 26, 2020 at 3:06 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > It is a hold-out from when we went from having a 32-bit var-off
> > and a 64-bit var-off. I'll send a patch its clumsy and not needed
> > for sure.
> 
> please follow up with such patches.

Great will go ahead and do this.

> 
> > The other subtle piece here we should clean up. Its possible
> > to have a const in the subreg but a non-const in the wider
> > 64-bit reg. In this case we skip marking the 32-bit subreg
> > as known and rely on the 64-bit case to handle it. But, we
> > may if the 64-bit reg is not const fall through and update
> > the 64-bit bounds. Then later we call __update_reg32_bounds()
> > and this will use the var_off, previously updated. The
> > 32-bit bounds are then updated using this var_off so they
> > are correct even if less precise than we might expect. I
> > believe xor is correct here as well.
> 
> makes sense. I think it's correct now, but I agree that cleaning
> this up would be good as well.
> 
> > I need to send another patch with a comment for the BTF_ID
> > types. I'll add some test cases for this 64-bit non-const and
> > subreg const so we don't break it later. I'm on the fence
> > if we should tighten the bounds there as well. I'll see if
> > it helps readability to do explicit 32-bit const handling
> > there. I had it in one of the early series with the 32-bit
> > bounds handling, but dropped for what we have now.
> 
> Not following. Why is this related to btf_id ?

Its not related at all. I was just looking at patches on my
stack here and I have unrelated comment only patch to clarify
PTR_TO_BTF_ID_OR_NULL and PTR_TO_BTF_ID.

> 
> > LGTM, but I see a couple follow up patches with tests, comments,
> > and dropping the duplicate ALU op I'll try to do those Friday, unless
> > someone else does them first.
> 
> yes. please :)

will do.

> 
> I've pushed this set to bpf-next in the meantime.
> Thanks everyone!


