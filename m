Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED86791B9
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 08:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjAXHPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 02:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXHPG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 02:15:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86D2D77;
        Mon, 23 Jan 2023 23:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqtdrcIQh0doLs5ICncqDJLHAC8tMhUvfthajetJCxQ=; b=qFROB4Dkc8xISIjMpSDgGWgvRn
        7QSEMmyXl2HYJjjD9/5jKHr7yXccUg6eNwyYUGPCLgAaSWAZ3U4BZrt53sFci13hTGegtWPhTFJRL
        XPltHXFXUVrsp7pzeRYtWp2To3OP8woghihKpz7S6HUipOPBosyDweSVV/SUtlZpl1Zy7RluNs7L6
        f++4Aapb2Rx3Qt3ZHwgxb0mGwNj1QnqasIPCyB40s4DbG50TlbAZLKO+a2oneaEAQZQIHMhNCkwL8
        Z7JpLA6XOZtl75moZRMvx2DZ0Ah3A6akKX0ZImJJYIQOBOW9CP/+P6D3aK3YLW8gvmuHxu6Jc3F+t
        oiZU8bUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDWK-002byh-Fb; Tue, 24 Jan 2023 07:15:04 +0000
Date:   Mon, 23 Jan 2023 23:15:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y8+FeH7rz8jDTubt@infradead.org>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171506.71995-4-void@manifault.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I don't think this is the way to go.  For one the syntax looks odd,
and for another count we had a rough agreement at the kernel summit
to make BPF kfuncs look more like export symbols.

So can you please try to instad make this a EXPORT_SYMBOL_BPF that
looks and feels more like EXPORT_SYMBOL instead?
