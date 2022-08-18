Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189159840D
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiHRN0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 09:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiHRN0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 09:26:16 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6CAB3B37;
        Thu, 18 Aug 2022 06:26:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4M7lrW4NjZz9xHdY;
        Thu, 18 Aug 2022 21:20:59 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3RhLaPf5iVW0wAA--.23197S2;
        Thu, 18 Aug 2022 14:25:54 +0100 (CET)
Message-ID: <71544d2970e246e1f0d5f5ec065ea2437df58cd9.camel@huaweicloud.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, quentin@isovalent.com,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 18 Aug 2022 15:25:36 +0200
In-Reply-To: <Yv46EW6KbUe9zjur@kernel.org>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
         <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
         <Yv46EW6KbUe9zjur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwB3RhLaPf5iVW0wAA--.23197S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8ZF48ZF15WrWkXw47urg_yoW8urW8pa
        4rG3WUKrsrKr1Ikw42kr18ta1F9w4Iy3yUXFy0yw17AF4UWF17KF1a9FWrWFyDurn3u3Wa
        vrWSq34ru3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UR7KsUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj34VsAAAsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-08-18 at 10:09 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 18, 2022 at 02:09:57PM +0200, 
> roberto.sassu@huaweicloud.com escreveu:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Sometimes, features are simply different flavors of another
> > feature, to
> > properly detect the exact dependencies needed by different Linux
> > distributions.
> > 
> > For example, libbfd has three flavors: libbfd if the distro does
> > not
> > require any additional dependency; libbfd-liberty if it requires
> > libiberty;
> > libbfd-liberty-z if it requires libiberty and libz.
> > 
> > It might not be clear to the user whether a feature has been
> > successfully
> > detected or not, given that some of its flavors will be set to OFF,
> > others
> > to ON.
> > 
> > Instead, display only the feature main flavor if not in verbose
> > mode
> > (VF != 1), and set it to ON if at least one of its flavors has been
> > successfully detected (logical OR), OFF otherwise. Omit the other
> > flavors.
> > 
> > Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main
> > flavor>
> > variable, with the list of the other flavors as variable value. For
> > now, do
> > it just for libbfd.
> > 
> > In verbose mode, of if no group is defined for a feature, show the
> > feature
> > detection result as before.
> 
> Looks cool, tested and added this to the commit log message here in
> my
> local branch, that will go public after further tests for the other
> csets in it:
> 
> Committer testing:
> 
> Collecting the output from:
> 
>   $ make -C tools/bpf/bpftool/ clean
>   $ make -C tools/bpf/bpftool/ |& grep "Auto-detecting system
> features" -A10
> 
>   $ diff -u before after
>   --- before    2022-08-18 10:06:40.422086966 -0300
>   +++ after     2022-08-18 10:07:59.202138282 -0300
>   @@ -1,6 +1,4 @@
>    Auto-detecting system features:
>    ...                                  libbfd: [ on  ]
>   -...                          libbfd-liberty: [ on  ]
>   -...                        libbfd-liberty-z: [ on  ]
>    ...                                  libcap: [ on  ]
>    ...                         clang-bpf-co-re: [ on  ]
>   $
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Thanks for working on this!

Thanks for testing and for adapting/pushing the other patches!

Roberto

