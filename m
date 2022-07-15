Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C2575ED4
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 11:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGOJwl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiGOJwl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 05:52:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153F7AB21;
        Fri, 15 Jul 2022 02:52:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z23so8067016eju.8;
        Fri, 15 Jul 2022 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQyfaIVWHYuidPiZUP1HqLZaITHaf3+B9Efs0k/aU6s=;
        b=lWJCiWbd2zR9sVyS2riq8M6ZP1YCrlG0Ty3OQH1pwdEtDqdqbnpPt8ujNQMbDJAhK8
         i0B/jywG+oz8JafJGB8/6QX5utgyowml0X3RNPiWXSwLM+OQIFg6f4T54O2TUufd3c+A
         lS2aaDfyexX5jgePo8fHgq5se+igAeVMWtr+ya+BTr0BC1QD5zvV1mpWGqjFL4ZljSHl
         VIVhe0gGl6UGbX19BiYxtDhL2/HcEFCTDTCevKY4vIVQRF1yO0MC8MPOLSj8gfmSCzVR
         eMhyXSS1gYaAk8egdJHm5V1HG7OX7UHXpveB8yJg2bZuhLwNs5eRzFCR6xyZEiAgykm/
         CDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQyfaIVWHYuidPiZUP1HqLZaITHaf3+B9Efs0k/aU6s=;
        b=LdPW8iZoMpb0SiGGfgRXXiT7Z1WtS3ap+0Ha17f9SRns2fgaGrf2N7K3F+vKLIDeii
         SkgYI/VJfXNbv4WPmCZfVO//Ud5zkWO1WFnWxhgISnPUj7q+DU4CBLpDKfxc55t4BBXg
         duGBVe67LmHykZlI08eEEQL3GKSzc8QH1kHAolI2JB3sosU5OSJ4KiMT65MBHkxahSdR
         QY0Tg3yGc1Z8Ag3/Gieisv7u5D9r5OUsB2bY/2Eeb51AHH8NBiv/Ebq7850I138Jv+AG
         ZpIvfKlNmCM3FsNG+SCTAGPv8bjDqExRPqNPVKM5ApUYhgc9cEQEay6My+fj3hXbzjSV
         EqPA==
X-Gm-Message-State: AJIora8JbokhGeFZ17JRqKdr8aRVgMF7o0dGHW8mPVvzyLaI4IpW4o5P
        OxZAH6wHDT+2fzR/OxeG9e0=
X-Google-Smtp-Source: AGRyM1u7TdRsBnIOQDpNZFJuktDXEicIjEJJ25lje+Lw7UOj4WTKEgBnvZcdRuLdFY+cdkE6xh63zw==
X-Received: by 2002:a17:907:75f2:b0:72b:564c:465e with SMTP id jz18-20020a17090775f200b0072b564c465emr12386439ejc.689.1657878758235;
        Fri, 15 Jul 2022 02:52:38 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-027-106.094.222.pools.vodafone-ip.de. [94.222.27.106])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090676d100b00704757b1debsm1850142ejn.9.2022.07.15.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:52:37 -0700 (PDT)
Date:   Fri, 15 Jul 2022 11:52:36 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, mingo@redhat.com,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220715095236.ywv37a556ktl5oif@ddolgov.remote.csb>
References: <20220714193403.13211-1-9erthalion6@gmail.com>
 <YtB1PK+NUF5RL9Er@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtB1PK+NUF5RL9Er@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Jul 14, 2022 at 09:57:48PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 14, 2022 at 09:34:03PM +0200, Dmitrii Dolgov wrote:
> > From: Song Liu <songliubraving@fb.com>
> >
> > Enable specifying maxactive for fd based kretprobe. This will be useful
> > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > Use highest 4 bit (bit 59-63) to allow specifying maxactive by log2.
>
> What's maxactive? This doesn't really tell me much.

Maxactive allows specifying how many instances of the specified function
can be probed simultaneously, it would indeed make sense to mention this
in the commit message.

> Why are the top 4 bits the best to use?

This format exists mostly on proposal rights. Per previous discussions,
4 bits seem to be enough to cover reasonable range of maxactive values.
Top bits seems like a natural place to me following perf_probe_config
enum, but I would love to hear if there are any alternative suggestions?

> > The original patch [2] seems to be fallen through the cracks and wasn't
> > applied. I've merely rebased the work done by Song Liu, verififed it
> > still works, and modified to allow specifying maxactive by log2 per
> > suggestion from the discussion thread.
>
> That just doesn't belong in a Changelog.

Agree.

> > Note that changes in rethook implementation may render maxactive
> > obsolete.
>
> Then why bother creating an ABI for it?

If I got Masami right, those potential changes mentioned above are only
on the planning stage. At the same time the issue is annoying enough to
try to solve it already now.

> > [1]: https://github.com/iovisor/bpftrace/issues/835
> > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> >
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Lots of question and not a single answer in sight...

I hope I was able to answer at least some of them, thanks for looking
into this!
