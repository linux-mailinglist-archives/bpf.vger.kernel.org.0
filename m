Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F155FE60A
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 02:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJNAD6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJNADy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 20:03:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB671578AF
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 17:03:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b4so5244087wrs.1
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twO0p5/xsK51AFSKG4/+NF4p0nXn+aIHiYgabetyYzM=;
        b=ogURrAxlnWu3vFqjB7rIY1G5B2xyvvoBnUC0V40Z0wdBZWqC60AnzlmZV9kyfON4XA
         pmtIzlTMvgjsxalBx5RzqguT6mOGzTecK+c2BBk2QvoqMvRCrKLjPICKYhtXVZp6n4cM
         JonlftWrVoFZQdkkaLjGmq5FzMO1UevuRmOXr1O74+K7TOivpjOEl6hUIPNfI1JZVtL0
         o2OQIVjdyNTVAPFgdIQUah+Ce6Mzk9obfMX20xKkpGpmGcIo4XKE72TEQOyflCPdga6V
         P92/3ejEUtxQH2H5H9158sRuxTEaagdKKxkBxJm0AVIqjumi0g08R271PUCTNYmEGw67
         eIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twO0p5/xsK51AFSKG4/+NF4p0nXn+aIHiYgabetyYzM=;
        b=dZHnZUIKGkFATuoZ+go15jM+E5RiK1Wna2Q0gdAiVA0TIqcW32YSkQcYxM3hjVOxOI
         xJDDM+IftJeC6tk/+zJ31AwEiFYAPlnHLqCVBCNGap3SCu32oTzCROXtetta4IOobIVv
         zDIIiQ7cFLI79YO7xFmkeKgiR/IfWVEbG6SZctjpoc6r7GbxadlKMNNz9UEGofTNXSVr
         gaZFst7/vkR4uaNNpz+18A59q9mFEzTZ9uhuW4bUWky/O2JHZ0n3myjYfxmtqWuPQhuf
         GogxUXmb/p/jdgrjy3OvzkLHOcQ+QS/nyB4Nc2jYkzyQP53EIyfnjOYwSazJRUZNh8mc
         VGhg==
X-Gm-Message-State: ACrzQf08xQ/3XdrHHgyO/HEkFvWhlxy3mhVIVqDgHkzZUey/STh5BNtg
        R1HfrlUw5Z+2Wj2oYhCgsoxnEJcFTIXuWQQrnTik6g==
X-Google-Smtp-Source: AMsMyM69o+xkxQCL0URhk14ropUJuWavWYXez2f/c8x1PekuXpo1/tfwcJbetPXOoEDA/xWRmULmY9gV2XQTFDm/GxM=
X-Received: by 2002:a5d:4909:0:b0:22e:7bbf:c8d with SMTP id
 x9-20020a5d4909000000b0022e7bbf0c8dmr1450837wrq.80.1665705831072; Thu, 13 Oct
 2022 17:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com> <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
In-Reply-To: <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 17:03:14 -0700
Message-ID: <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
>
> On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > So I think it reasonable to say its bounded by approximately  2 *
> > NSEC_PER_SEC/HZ +/- 11%.
>
> Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11

Thanks so much for the detailed response :)

IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
(essentially 0)? I feel like I miscalculated, this error bound is too
good to be true.

>
> thanks
> -john
