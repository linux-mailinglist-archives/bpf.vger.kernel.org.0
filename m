Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9145E5BF165
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiITXm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiITXmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 19:42:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF067144
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:40:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r18so9821887eja.11
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sBvvo1075jmRAUVT4RTpdkKYu5ofw6jTWvXU5oY15rM=;
        b=A5LyEwNZB27ihqCA2MmM7UvodZEMEu01kZ1q1xqNZjte0bT5Cp8whi3/N7koPvEWAg
         r6o5Y8R2qvunux1r17gNmxeyYaW5Tf9+TWOMlGhnTl5PjdgMQs7Fl03+hsDnnojKu/Lq
         QDk9TxK4Hck6hpCNkWKockR3DIOFkEXJkJcBp4pJgw3ksddvtbldJftWEH8Tm8ere4nN
         WoLA4g0LFG2OeSZsyL6oTJlqb9Xr683pmC1gPKYPOGcROWPwvIQ5OY4dHLFR5mUFIjjf
         LxcVOTEfEnN0+/p3yFQaGTnG1eZLvjueHVLSrOQ6bpZp5fqgeP9D+8bqA3CuRYNwmEIf
         r99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sBvvo1075jmRAUVT4RTpdkKYu5ofw6jTWvXU5oY15rM=;
        b=cEvTC2OHf/2pxJ3Cz2u0amAW54cicanLKXT3EqR9yXEUqDJJO3CMcxpBGdJvaTY1qI
         vRcDR72AFJzXhzFUHfpqi81UiXGUMkAGBosCix0dGgVzEH5l6Fvo31rZhzihTJUzfa/o
         aDskqYXDr2AIjT+S5tNqa7Gct0R4MHdzC55RCM/QVlnFjj5aFHiNOZTvgOhvrz00+hxF
         zxujg66rJLZJ/prqxUrhM+QrhlC470vEL+V6HFsX5O1N7ofNfdGaPO31WpHkJEkrJB3Y
         F+jJ8mzT/nVsgi0u80kr85YUe5BG7cGHT9EN61rEkoQO2yrIfor4/YNeSUOymaR4P5YQ
         zQIA==
X-Gm-Message-State: ACrzQf3qn9e5vgdaEQ9nPSS2KTAUiCzGCt+e7+NXZCo1xr5ALinfP3aq
        ht5vSjE7rxPUMcB6noSkybKZn/Dv6//Ey+2qHd8+wTLC
X-Google-Smtp-Source: AMsMyM4UEk0PHGrZUvzkLG/KHibdnKs16l6m8pPpmhHt31dVrI0wYAo14IWMII5jMu6WE5ABrvVGMPIeGAaZDFZY8+g=
X-Received: by 2002:a17:907:2d21:b0:77d:4f86:2e65 with SMTP id
 gs33-20020a1709072d2100b0077d4f862e65mr18341333ejc.58.1663717203238; Tue, 20
 Sep 2022 16:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org> <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Sep 2022 16:39:52 -0700
Message-ID: <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>
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

On Tue, Sep 20, 2022 at 12:51 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Christoph Hellwig <hch@infradead.org>
> > Sent: Monday, September 19, 2022 10:04 AM
> > To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> > Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
> >
> > On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > > As discussed in yesterday's session, there's no graceful abortion on
> > > division by zero, instead, the BPF verifier in Linux prevents division
> > > by zero from happening. Here a few additional notes:
> >
> > Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> > defined to return 0 following.  Ok, reading further along I think that is what
> > you describe with the pseudo-code below.
>
> Based on the discussion at LPC, and the fact that older implementations,
> as well as uBPF and rbpf still terminate the program, I've added this text
> to permit both behaviors:

That's not right. ubpf and rbpf are broken.
We shouldn't be adding descriptions of broken implementations
to the standard.
There is no way to 'gracefully abort' in eBPF.
There is a way to 'return 0' in cBPF, but that's different. See below.

>
> > If eBPF program execution would result in division by zero,
> > the destination register SHOULD instead be set to zero, but
> > program execution MAY be gracefully aborted instead.
> > Similarly, if execution would result in modulo by zero,
> > the destination register SHOULD instead be set to the source value,
> > but program execution MAY be gracefully aborted instead.
>
> And elsewhere in the doc defined gracefully aborted as:
>
> > After execution of an eBPF program, register R0 contains the exit code
> > whose meaning is defined by the program type, except that an exit code
> > of -1 means the program was gracefully aborted.  That is, if a program
> > is gracefully aborted for any reason, it means that no further instructions
> > are executed, and a value of -1 is returned in register R0 to the caller of
> > the program.
>
> The problem with that, as Quentin pointed out, is that -1 is a valid return
> code from some program types like TC.  Do we suddenly declare
> uBPF etc as being non-compliant?

yes. ubpf is non-compliant.
-1 is just a radom number that ubpf picked.
Classic BPF defines a certain situation for obsolete LD_ABS
as 'return 0'.
We had to keep it this way due to classic baggage,
but, as we agreed, we're not going to define these two classic insns
in the standard doc.
So there should be no 'graceful abort' paragraph anywhere
in the standard.


> My preference is just to document
> the issue, since such runtimes might choose to make -1 be a reserved
> value for all program types they support.  After all the ISA does not
> define program type details so they can use the ISA without TC etc.

We can document with certainty the returns codes of XDP prog type
and stress that they should be the same across all run-times.
There is no reason for windows to be different from linux in XDP progs.
What to do with TC and other returns codes is a different matter.
