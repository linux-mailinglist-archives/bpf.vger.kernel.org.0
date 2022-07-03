Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D956466E
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiGCJd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiGCJdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 05:33:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698123892;
        Sun,  3 Jul 2022 02:33:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so11673446ejb.6;
        Sun, 03 Jul 2022 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qN6TJiBzUxNdaAU6Co/vYWar8RPEaCWtbXsoQnQcIco=;
        b=nip9Z/1qj7dJOHdJz9EqBkdU3JcEmxG0opD7kOyK8tFP0ol1GM7c+2zL4h9UI0V8eJ
         zFDQ61hqfotB3j/A6fgewg9zKxP1E1I0hSo7Wa+xCniB0/5Vl5uoH0F7qaAqWETGtbH3
         XkRtOVFgTXy3DWE/z1YjpY+YW/p2m5Ld69eqOacqoRoIRABiWnJ0C8REdnqXEL6SkjbN
         UVLCunLQwYvNhFU3YRuu0mmi+S3pV4pjTQXMWTpvuUQJEN+7l6FLpTJgn6kHJlrnFoSK
         XN8TDffnDvHQVRrFWakQmRpHFFkt7ruZU04CwF1eqzbIUFZFO/AkV8DBvXA/2duhW+73
         v0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qN6TJiBzUxNdaAU6Co/vYWar8RPEaCWtbXsoQnQcIco=;
        b=FPPkaBKgl8OAvzLf6Cj6uPjqKbzcwPaCjuoUp0Fcgx/eJhMBgrP3Iy2PsSi/W7HC3q
         F/OElADstZcIkh6Q5AZDmJJzkcx+r0vrSZc7K0bEYAGFuf+5rOpr91ZQaOBqklS0e0Vg
         yifvg4EXIY5329HIHe19LbaF6Dqs26edrqGqH8QEonGz8NwdOYad1L5lNDNWQig0xemx
         7qVaSR8lTGgxreDN8GFp9TL1OlH7r7Nob/DuX1a+9X+GJgimgurnP/dorYDhuI7sSWc0
         odWC583zureybZp6Qiikfi1UnQm1C4lOAUOgv8ZNBJvosex3TJj88abVdac9q2Y8X7Df
         XfFA==
X-Gm-Message-State: AJIora9GdRy7xlFiipXWDKYKCRuyBAFH7q37kAOOcmsAgdoxCQe7uM+I
        84TDk7dQhogPOPcaScnYK+I=
X-Google-Smtp-Source: AGRyM1uI75SkT5SuiOCumbsbjx+WyzWwxISdA50+mdBdzoDW8h0TmV2Bb/Cqo2rTUFrHKI8vykEeEQ==
X-Received: by 2002:a17:906:8a53:b0:72a:8a2d:db61 with SMTP id gx19-20020a1709068a5300b0072a8a2ddb61mr12488186ejc.674.1656840802907;
        Sun, 03 Jul 2022 02:33:22 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906084f00b00718d18a1860sm12819498ejd.61.2022.07.03.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 02:33:22 -0700 (PDT)
Date:   Sun, 3 Jul 2022 11:32:16 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220703093216.5qpxfvza5dhuknru@erthalion.local>
References: <20220625152429.27539-1-9erthalion6@gmail.com>
 <20220627113731.00fa70887d19a163884243fa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627113731.00fa70887d19a163884243fa@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, Jun 27, 2022 at 11:37:31AM +0900, Masami Hiramatsu wrote:
> On Sat, 25 Jun 2022 17:24:29 +0200
> Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> > From: Song Liu <songliubraving@fb.com>
> >
> > Enable specifying maxactive for fd based kretprobe. This will be useful
> > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > Use highest 4 bit (bit 59-63) to allow specifying maxactive by log2.
> >
> > The original patch [2] seems to be fallen through the cracks and wasn't
> > applied. I've merely rebased the work done by Song Liu, verififed it
> > still works, and modified to allow specifying maxactive by log2 per
> > suggestion from the discussion thread.
> >
> > Note that changes in rethook implementation may render maxactive
> > obsolete.
> >
> > [1]: https://github.com/iovisor/bpftrace/issues/835
> > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> >
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
>
> This looks good to me.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks. Is there anything else I can help with to get this change
committed?
