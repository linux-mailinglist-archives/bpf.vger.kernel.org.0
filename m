Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F715EC2A3
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiI0M0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 08:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiI0MZ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 08:25:57 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6E5D0E1;
        Tue, 27 Sep 2022 05:25:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4McJbN3hPnz9xHdt;
        Tue, 27 Sep 2022 20:19:44 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnnpKo6zJjXcR8AA--.32036S2;
        Tue, 27 Sep 2022 13:25:20 +0100 (CET)
Message-ID: <55ad7ac680a8300a7f1f6e28f16d98f34223468a.camel@huaweicloud.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        Jiri Olsa <olsajiri@gmail.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        quentin@isovalent.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 27 Sep 2022 14:25:09 +0200
In-Reply-To: <YzLq5uar4dZlT1s6@kernel.org>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
         <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
         <YwNhabqHEq3PfNM8@krava>
         <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
         <75986095d7ada2b24784ef356abc6ce17307575d.camel@huaweicloud.com>
         <YzLq5uar4dZlT1s6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnnpKo6zJjXcR8AA--.32036S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4xGFy5WFy3Kw15WryxuFg_yoW8GF47p3
        yrJayftr4DXr1rAa1qyw15Zrs0krZrta1DX3yrW347Z3ZF9rnakF1Ikay8uF9rG34rur12
        vrW8Xa47ZryUC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4OAUAACst
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-09-27 at 13:21 +0100, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 27, 2022 at 09:14:34AM +0200, Roberto Sassu escreveu:
> > On Mon, 2022-08-22 at 13:24 +0200, Roberto Sassu wrote:
> > > On Mon, 2022-08-22 at 12:58 +0200, Jiri Olsa wrote:
> > > > On Thu, Aug 18, 2022 at 02:09:57PM +0200, 
> > > 
> > > [...]
> > > 
> > > > > In verbose mode, of if no group is defined for a feature,
> > > > > show
> > > > > the
> > > > > feature
> > > > > detection result as before.
> > > 
> > > Thanks Jiri.
> > > 
> > > 'or' instead of 'of', if the patch can be edited.
> > 
> > Hi Arnaldo
> > 
> > will you take these patches?
> 
> The tools/build one I have in my perf/core branch, for v6.1.
> 
> ⬢[acme@toolbox perf]$ git log --oneline --author 
> roberto.sassu@huawei.com tools/{build,perf,lib}
> 924b0da1154fa814 tools build: Display logical OR of a feature flavors
> 1903f4ac2f3a6d33 tools build: Increment room for feature name in
> feature detection output
> 48ab65e0fec644b4 tools build: Fix feature detection output due to
> eval expansion
> 5b245985a6de5ac1 tools build: Switch to new openssl API for test-
> libcrypto
> dd6775f986144a9e perf build: Remove FEATURE_CHECK_LDFLAGS-
> disassembler-{four-args,init-styled} setting
> 629b98e2b1c6efcf tools, build: Retry detection of bfd-related
> features
> ⬢[acme@toolbox perf]$

Oh, thanks. I had a quick look today at the web interface. I didn't see
them.

Roberto

