Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED735EBB53
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiI0HPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI0HPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 03:15:08 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F766C11E;
        Tue, 27 Sep 2022 00:15:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mc9hz4sjmz9xqd9;
        Tue, 27 Sep 2022 15:09:07 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXT5PdojJjCNt7AA--.18934S2;
        Tue, 27 Sep 2022 08:14:45 +0100 (CET)
Message-ID: <75986095d7ada2b24784ef356abc6ce17307575d.camel@huaweicloud.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        Jiri Olsa <olsajiri@gmail.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        quentin@isovalent.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 27 Sep 2022 09:14:34 +0200
In-Reply-To: <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
         <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
         <YwNhabqHEq3PfNM8@krava>
         <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBXT5PdojJjCNt7AA--.18934S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUU
        UUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj398ggAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-08-22 at 13:24 +0200, Roberto Sassu wrote:
> On Mon, 2022-08-22 at 12:58 +0200, Jiri Olsa wrote:
> > On Thu, Aug 18, 2022 at 02:09:57PM +0200, 
> 
> [...]
> 
> > > In verbose mode, of if no group is defined for a feature, show
> > > the
> > > feature
> > > detection result as before.
> 
> Thanks Jiri.
> 
> 'or' instead of 'of', if the patch can be edited.

Hi Arnaldo

will you take these patches?

Thanks

Roberto

