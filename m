Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F4687F96
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 15:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBBOKu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 09:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBBOKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 09:10:50 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125489F84
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 06:10:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id m26so1873842qtp.9
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hv+a3eL6VMETyn2zLBDdt445PHXLpn20V13XQB5xq10=;
        b=HGdxufHzZVlMVMI9/MGyDJkL80VDfNXdts11g+nmFAnOX6qlAMPhqsFEiZpK30mzDW
         ljbuR2FEFDchqCMBBRegn4qnoy96SyO2cnFHxqgK12+VF8AD+8tWuP4i5YmXu4a7g/4a
         AYUb96EC8oywhOQzoG+uOykNSfVeHa8N2PzptN4SO89sbIGMJ/O6pdIhDD5fV+uswFjS
         yQt5r+tyo2LOGe92oO+LyJE/cQTY4fWbgN8LINV6/nOIoVjPl4tIb8n8uUXkhqsWfjRE
         EkoONFJ6mPx6pkHlTfY4zw9zTh71APYPB1WLg9s2aT/jkWtPrf73MoRhBjrAHXy5uy1/
         QcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv+a3eL6VMETyn2zLBDdt445PHXLpn20V13XQB5xq10=;
        b=e5KjCOY3b8kGeK87iy4VrmQEx2NC5E6BXpRkRy+yN7vOYScEUyDjMXLIuk1myFCCNy
         skLYV/5c6INYkjDsINmIPZPNVsRQilu+SBwaGcGnUtx+Qdj+ncmlw0miESXWvvMc5l1A
         87tcp9Z58pWIBUad+D2FMWzBCq8OIlntOzbl7q8ZhyrQc5H191bv4TQS/1LwcBkcqDF8
         zfZB53j6B6pUj+SFImhdL7Fx6cxogVakRXbyrW/mbhz/1klmSqUwENw8kYSr80U0aspG
         bv1ix2EsLCqurMOu3MfHbXqIBaFvK71aoeXI41d2H6trbKKRXHUIPXHzIRgsYV6NNOXb
         0Xmg==
X-Gm-Message-State: AO0yUKWnYt/zyrhzLO5n4CDbi4WVuEr/IbAubCv84T2Q9CLr3KYVKAzb
        pjPj4E2Nv7g0o0VVslpbm0XXhImzw5iiMWVSDBw=
X-Google-Smtp-Source: AK7set+0homhPVsR1sbYpFkZ+BOMFucfGPKRPiIRZgDvjCblx9Sjiwfby/+L3GDADodOAu3MaUjmnB0q66F5XM39Zj8=
X-Received: by 2002:ac8:5fd2:0:b0:3b9:b148:b734 with SMTP id
 k18-20020ac85fd2000000b003b9b148b734mr803830qta.65.1675347048416; Thu, 02 Feb
 2023 06:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-4-laoar.shao@gmail.com>
 <Y9uPORBkVlMZFzk3@infradead.org>
In-Reply-To: <Y9uPORBkVlMZFzk3@infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 2 Feb 2023 22:10:12 +0800
Message-ID: <CALOAHbBttv8YEFkqQkpeHnJ8kDAmxHPnK1DEv_ZNOvnK9=BGWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] mm: vmalloc: introduce vsize()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 6:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Feb 02, 2023 at 01:41:54AM +0000, Yafang Shao wrote:
> > Introduce a helper to report full size of underlying allocation of a
> > vmalloc'ed address.
>
> What is the use case for it?

The use case is in patch #4 and patch #7, to get the bpf memory usage
from the pointers.
#4: https://lore.kernel.org/bpf/20230202014158.19616-5-laoar.shao@gmail.com/T/#u
#7: https://lore.kernel.org/bpf/20230202014158.19616-8-laoar.shao@gmail.com/T/#u

I forgot to Cc you the full patchset. Sorry about that.
The full patchset is at
https://lore.kernel.org/bpf/20230202014158.19616-1-laoar.shao@gmail.com/

-- 
Regards
Yafang
