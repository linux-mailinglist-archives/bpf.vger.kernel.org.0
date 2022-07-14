Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18EA5754C2
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbiGNSQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGNSQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:16:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD067CAA;
        Thu, 14 Jul 2022 11:16:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w2so3099462ljj.7;
        Thu, 14 Jul 2022 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2QX/Lxw1dM3em+AdcVNETTOfkI14eEfg7V1aSOQdTQM=;
        b=cL80WLc/zql6U7gVA/bMoRIaeyJja2A7Hl+8eM1sjIXk66Z69jRPAKragoT+s5oy5k
         1a8lc7LUo/0ZDCf2dAYC7YpNREsVd0CncKUzvRERTqnIbl3jCZT/M+6Mlz90DZP0LPBn
         cf7++pETwaA0ZfmkxaCN/CL2O2mgZP+X6tA3x+MxPdsIhW2wvuAEQjL0l4mloz5KY2uk
         HbSkdnKi7NbTpl4TVaQnbMbMDVLWqeE9PTKvc1LDsEBZDNUeWqyY+Rf1n3G/9Zmj34gZ
         PP5eWPuOXKBifT8R/noIRJY4rZywnQduq1Rncu2XnGHyRKmzuXz2etugNPmcDSmBV6ws
         tBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2QX/Lxw1dM3em+AdcVNETTOfkI14eEfg7V1aSOQdTQM=;
        b=NBIqa2uPmu4FOQsfyZXBLExLsE8ki7pkd/69xduT0fpiHbSjXavA5XhwhNsB53gjYx
         dLMAIQD0bqKsx4mW/lyXv9+uFwYOsGuRmoEZre2vza1BidGUUezQMSl85B6hepXW7+jJ
         BvIna74YyOcnjrxy5OUyMad0WzLGMVuFHBxq2Fc1RJdD82/fFJFaSBnyb8WD9kQhsJEU
         0euIgznbgKSUyS3YoAR4K+ZvCXYvfMCWLu80LQeyaoKOcEW6vlKURg/bAOpafuMWJV7a
         E0tQ1XqK697eI9EtdZRSUihTOWiO1JS3831rjzmQ5SC5Kb2JxLEoXPubBn+wV5GsTLqE
         XoOQ==
X-Gm-Message-State: AJIora9pylqZUe3wqix7wi0GtMMnBELGnN3c0xindONjVDGm2rL9NUpi
        A1BmjTpbc+bn1RX40hfW4Pw=
X-Google-Smtp-Source: AGRyM1tpHk0AhqgOpToqpDTVrMgKe6SHJxLYZZJu+FPz/pCXoZQpyRbm608wTJYHdeLLsSOS4dK+hQ==
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id h12-20020a05651c158c00b00250a23d2701mr5429808ljq.475.1657822560608;
        Thu, 14 Jul 2022 11:16:00 -0700 (PDT)
Received: from pc636 (host-90-235-11-208.mobileonline.telia.com. [90.235.11.208])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05651c232000b0025bbd5e3febsm386358ljb.132.2022.07.14.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:15:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 14 Jul 2022 20:15:56 +0200
To:     Song Liu <songliubraving@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <YtBdSYbCyGJeIHHO@pc636>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6ZkDUhRZcmvPYy@infradead.org>
 <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
 <Ys+aVKFJaQd130Pn@infradead.org>
 <8AC2399B-F3B2-4F91-B18C-D9D3D5085471@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8AC2399B-F3B2-4F91-B18C-D9D3D5085471@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 04:54:40AM +0000, Song Liu wrote:
> 
> 
> > On Jul 13, 2022, at 9:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Wed, Jul 13, 2022 at 03:49:45PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Jul 13, 2022, at 3:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
> >>> 
> >>> NAK.  This is not something that should be an exported public API
> >>> ever.
> >> 
> >> Hmm.. I will remove EXPORT_SYMBOL_GPL (if we ever do a v2 of this..)
> > 
> > Even without that it really is not a vmalloc API anyway.  
> 
> This ...
> 
> > Executable
> > memory needs to be written first, so we should allocate it in that state
> > and only mark it executable after that write has completed.
> 
> ... and this are two separate NAKs.
> 
> For the first NAK, I agree that my version is another layer on top of 
> vmalloc. But what do you think about Peter's idea? AFAICT, that fits
> well in vmalloc logic. 
> 
I am not able to find the patch/change to see what you have done. But
please do not build a new allocator on top of vmalloc code. We have
three different ones what make things to be complicated :)

--
Uladzislau Rezki
