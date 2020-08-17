Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7F246EB3
	for <lists+bpf@lfdr.de>; Mon, 17 Aug 2020 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgHQRfG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731270AbgHQQcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 12:32:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173CC061389;
        Mon, 17 Aug 2020 09:32:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so7795985plt.3;
        Mon, 17 Aug 2020 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fnadU0endxTJrjCWkn0d+ZnsZxebwsBLZgmqhdCClE=;
        b=HaRh2oAr/28YRXyp84yPvdQicVYQLopK5fqSZzrMK8167NQCYsnWS0IAeeIR601FmP
         AKxm8nQcKeQ+iEHW1mi1gxR98i9w0hf7EZDqd6RfBrzHhGrehFdH4Qg54g5ORPAdYNB4
         O00OM9jbl6vZ5PNOZXuijgv3aUd2+4pJ3yGhWI79AmvS7F8EGjE9aEMIDmFh2ZNfbZoG
         p4yFc4qkXFpmpwUVu/HCbZ2QSM13iWYyS/5YkWs5MwtIwo3BCz4TejvfqZIvPH+yUt2z
         MiDNjH6bbTWpuap218pmPaZGgiqlhjlWewOQg+xRrEqnSR+pA3rKxvZAi4vZ/f7fKi5P
         Y0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fnadU0endxTJrjCWkn0d+ZnsZxebwsBLZgmqhdCClE=;
        b=b8DUAHlxkDkenfVOLaZvBXO5g+/0Px+DIWWPVcWg855/2MiO6a/mkq1k8lAfmPmkYz
         XSyP3bKe0Kv3lPmex1H5ef0WV1FSmi34gh7eVSKrKnSfdBJ2nWDUG3h/PUnS7QTbSoRh
         1kJIaL+sHXVHnq6zxZpgvl07jZqd5YGp8WiQK7txD/Qz8K+OXa7ghQpg74l+OR7X+Dfl
         GpHTnYrt433yXje0a0mtz1key2izoOU3Gs3Q7vzDBIcWcU8tnhZAbzz7sezoBgP7tvkN
         XziMfN69IYC7BX1YLPtY361ITQ3MKWSXjDYqYH1xTwlSsRdb5JDVNlqiTDWmeLioOhhr
         wjEA==
X-Gm-Message-State: AOAM533B6/lQZx1Qa4qhvY/ZDDQ5dIRXrOnuILCbc2jAOAAe6Kg1kSbs
        2iJCJmGb6XNSgZ1biWLYzCw=
X-Google-Smtp-Source: ABdhPJx255oCAELzmNoOA+p2uz0NUKmytYbiEfpuMZPjaXBxkgLgBp5HvrTzY6V7FkZkq74fXIf+Kg==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr12679271pjs.168.1597681931139;
        Mon, 17 Aug 2020 09:32:11 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:20fd])
        by smtp.gmail.com with ESMTPSA id t25sm20140404pfe.51.2020.08.17.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:32:10 -0700 (PDT)
Date:   Mon, 17 Aug 2020 09:32:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, bpf@vger.kernel.org,
        linux-block@vger.kernel.org, orbekk@google.com,
        harshads@google.com, jasiu@google.com, saranyamohan@google.com,
        tytso@google.com, bvanassche@google.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200817163207.p53guehd7kpxfvat@ast-mbp.dhcp.thefacebook.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
> > +
> > +/* allows IO by default if no programs attached */
> > +int io_filter_bpf_run(struct bio *bio)
> > +{
> > +	struct bpf_io_request io_req = {
> > +		.sector_start = bio->bi_iter.bi_sector,
> > +		.sector_cnt = bio_sectors(bio),
> > +		.opf = bio->bi_opf,
> > +	};
> > +
> > +	return BPF_PROG_RUN_ARRAY_CHECK(bio->bi_disk->progs, &io_req, BPF_PROG_RUN);
> 
> 
> I think pass "struct bpf_io_request" is not enough, since we may want to do the filter based on
> some special patterns against the io data.
> 
> I used to pass "page_to_virt(bio->bi_io_vec->bv_page)" into ebpf program..

Bob,

Just like other bpf uapi structs the bpf_io_request is extensible and
such pointer can be added later, but I have a different question.

Leah,

Do you really need the arguments to be stable?
If so 'opf' above is not enough.
sector_start, sector_cnt are clean from uapi pov,
but 'opf' exposes kernel internals.
The patch 2 is doing:
+int protect_gpt(struct bpf_io_request *io_req)
+{
+       /* within GPT and not a read operation */
+       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
+               return IO_BLOCK;

The way ops are encoded changed quite a bit over the kernel releases.
First it was REQ_WRITE, then REQ_OP_SHIFT, now REQ_OP_MASK.
From kernel pov it would be simpler if bpf side didn't impose stability
requriment on the program arguments. Then the kernel will be free to change
REG_OP_READ into something else. The progs would break, of course, and would
have to be adjusted. That's what we've been doing with tools like biosnoop.
If you're ok with unstable arguments then you wouldn't need to introduce
new prog type and this patch set.
You can do this filtering already with should_fail_bio().
bpf prog can attach to should_fail_bio() and walk all bio arguments
in unstable way.
Instead of:
+       if (io_req->sector_start < GPT_SECTORS && (io_req->opf & REQ_OP_MASK) != REQ_OP_READ)
you'll write:
  if (bio->bi_iter.bi_sector < GPT_SECTORS && (bio->bi_opf & REQ_OP_MASK) != REQ_OP_READ)
It will also work on different kernels because libbpf can adjust field offsets and
check for type matching via CO-RE facility.
Will that work for you?
