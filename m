Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700DB25E018
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIDQqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgIDQqP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 12:46:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81ABC061244;
        Fri,  4 Sep 2020 09:46:13 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u126so7724273iod.12;
        Fri, 04 Sep 2020 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dpQ6nvSXQb2Xj+J3gZcbN6uDebmKzL9sxBjJW/LYckg=;
        b=X1Om7gP+mhlsQhbr4nVkes3gD+XSnwIX25mawKB/yCPnX9ZrKoQfM8ZH+KWmXURG3c
         S3SSkiylp1qTQeKXQO78bcZoh8drJZMwMgXp0RfX48Bs1rur6FE81N2/a0SR1pmLyKFb
         qvz7ePjfcnuKoN+QPw3NDxusgQLytCcKbg6aGp9k7MOAfNyp0Jpl8iMXUXYDFVU8kKNA
         ASm8iJMZL3hPhSPchewYrOPMZKgQCNqfV2jLvRgw2dThMJVEXF8mIdXps72foOMeETky
         R73c1mzFQTk6PqNc8IheQfP+AujAwmmVGDDGQu/ZLyo07oZzo0zDgWZ7opxXXujvddLL
         CsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dpQ6nvSXQb2Xj+J3gZcbN6uDebmKzL9sxBjJW/LYckg=;
        b=M4k4hPH3xm75+dHiDCMxgyQBphqvhOfo3wqVUEaTBjq3/1721QKAIWlcgJNLoE5Qez
         p4dnzgYxfc1FZxgPplYvuNSqNLm1uCNnMe5cl0LwTXHC/y3qNHz1a+LzyQ+TAlATDH8Q
         5TTP9au7FiGw6trRQupEEqiMDXyrYjZbmfAzfZuL9VrT+j788WfBUmIIB9VkbYw+GS0n
         vDOWhS98F/CBonrLQavpvzHkUOOE/z8cZH4JafEQ72SSd8uABMLywa0+YZSVrybLopRZ
         zf9ExyxddXJByWwzmt8BSQtq7JX0ZuBBh4twGf4+6vZL7GrczTz84anHwgFed4c9sTkq
         r7oA==
X-Gm-Message-State: AOAM530bZdo7QGsMQUM/JOJi46e2lx6OBJYLxpf2wlMCi9VwO1uKa+ph
        HYlit/V5aXeYnzbKvEG7fDA=
X-Google-Smtp-Source: ABdhPJzjDpENyYycFKhxs3HhiQlrOfWZDK7RymkTSxuUXu+4GCH/Prulk2zNhKFwcrKqCBOVvrrz6w==
X-Received: by 2002:a5d:980f:: with SMTP id a15mr8219405iol.12.1599237969388;
        Fri, 04 Sep 2020 09:46:09 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:e82f:35f2:cc6c:cdf5])
        by smtp.gmail.com with ESMTPSA id s6sm2364578ilp.4.2020.09.04.09.46.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 09:46:09 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:46:06 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Bob Liu <bob.liu@oracle.com>, bpf@vger.kernel.org,
        linux-block@vger.kernel.org, orbekk@google.com,
        harshads@google.com, jasiu@google.com, saranyamohan@google.com,
        tytso@google.com, bvanassche@google.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200904164605.GB2048@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
 <20200817163207.p53guehd7kpxfvat@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817163207.p53guehd7kpxfvat@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:07AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
> > > +
> > > +/* allows IO by default if no programs attached */
> > > +int io_filter_bpf_run(struct bio *bio)
> > > +{
> > > +	struct bpf_io_request io_req = {
> > > +		.sector_start = bio->bi_iter.bi_sector,
> > > +		.sector_cnt = bio_sectors(bio),
> > > +		.opf = bio->bi_opf,
> > > +	};
> > > +
> > > +	return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
> > 
> > 
> > I think pass "struct bpf_io_request" is not enough, since we may want to do the filter based on
> > some special patterns against the io data.
> > 
> > I used to pass "page_to_virt(bio->bi_io_vec->bv_page)" into ebpf program..
> 
> Bob,
> 
> Just like other bpf uapi structs the bpf_io_request is extensible and
> such pointer can be added later, but I have a different question.
> 
> Leah,
> 
> Do you really need the arguments to be stable?
> If so 'opf' above is not enough.
> sector_start, sector_cnt are clean from uapi pov,
> but 'opf' exposes kernel internals.
> The patch 2 is doing:
> +int protect_gpt(struct bpf_io_request *io_req)
> +{
> +       /* within GPT and not a read operation */
> +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> +               return IO_BLOCK;
> 
> The way ops are encoded changed quite a bit over the kernel releases.
> First it was REQ_WRITE, then REQ_OP_SHIFT, now REQ_OP_MASK.
> From kernel pov it would be simpler if bpf side didn't impose stability
> requriment on the program arguments. Then the kernel will be free to change
> REG_OP_READ into something else. The progs would break, of course, and would
> have to be adjusted. That's what we've been doing with tools like biosnoop.
> If you're ok with unstable arguments then you wouldn't need to introduce
> new prog type and this patch set.
> You can do this filtering already with should_fail_bio().
> bpf prog can attach to should_fail_bio() and walk all bio arguments
> in unstable way.
> Instead of:
> +       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
> you'll write:
>   if (bio->bi_iter.bi_sector < GPT_SECTORS && (bio->bi_opf & REQ_OP_MASK) != REQ_OP_READ)
> It will also work on different kernels because libbpf can adjust field offsets and
> check for type matching via CO-RE facility.
> Will that work for you?

Alexei,

I need the arguments to be stable. What would be the best way to go
about this? Pulling selected information from the opf field and defining
my own constants?

Thanks,
Leah
