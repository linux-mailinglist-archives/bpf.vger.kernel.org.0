Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D225F6F90
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiJFUoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJFUoi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 16:44:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36725CD
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 13:44:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so7239455ejb.1
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i2ulxiHN8mEgdTOgBOqzDVQ9jKpHsDSye2eGR/zS5Ik=;
        b=m0FQxZjwiCxQkBcij6PWGJYP+ifkaVbCq+Z7VcVe2d4Mq+r5WuJyIsYID7JbP2Yglt
         +DpeXNwS8Jx3OaDGpfIVqO0YFsmxLsVS7iRr1+y20VXY/X+cdNOGIjmhroWXPKGmy0I9
         oUF0WFubH88T+63SksbhA7xZ7jqN6/jlGmD1BKMxXwnfUVr4W+UvM0Rtg4zUrYT5hsw7
         j4PfGv7dJybqo5kax3FiqPJFan182z/LifQnhEJbbNFs2JA16Nc1eomEFsrNdecFrOni
         Yht++9JehW917Cv9Isay8HJAy8/fzqBq5wp1ekrO9jK3LLXa0vTdh1PG5LNhYL/abkve
         p11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i2ulxiHN8mEgdTOgBOqzDVQ9jKpHsDSye2eGR/zS5Ik=;
        b=gh6BFTQFs0X2ByqQ8/5wjaImd+zVm5PKQJCinXkMmn8CeJZWXT9O+Q7onBzVdHCpim
         nO2/ytJBOnKMcIvyrdX82rYg0BNP6tzrOeRJPPBV4QrE/fQIKKmURi5Mm2wWFICKlGMe
         kEeyyctnNcLv72vAt0NTS7/vUko7sqhDkmro6C/8LksgwUundqGdlfkz5XxVcIkbcFQ6
         FyExf5R4oz4ulSTZkyCcxso5oi01TpXezFTqeAcKZvAUrnEv61ILo5KRFWcgyrklFXV7
         uQJlxsU5E3ZvNHo6hgrabh/2/056DF/DNf0ayWP1mNN9wtwo6SNyluhMuXi9OmjHrWig
         3xMg==
X-Gm-Message-State: ACrzQf2ulRapraoY6Z2eSgsG5ASn6y8GqGNYivDNZfx9KyqPL//jVkrJ
        HnyaSZ2DiDlT7cxFVqKGign8CzmBEFgeQGEZGug=
X-Google-Smtp-Source: AMsMyM76bNkgPudJiNcVbfr8roBEloJG6Otfl3hgAc/okUP8sNVEdVZ8R2vAIGROe2OrXyYtvnw094LVCvWlYhDU6Gs=
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id
 hg24-20020a1709072cd800b0077664a81adfmr1381282ejc.151.1665089075072; Thu, 06
 Oct 2022 13:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-11-dthaler1968@googlemail.com> <20220930221624.mqjrzmdxc6etkadm@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440664B3010ECDDCF9731D1A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJQvdN2Dm7pwMno59EhMB6XT35RLMY4+w_xhauJ0sdtAQ@mail.gmail.com>
 <DM4PR21MB3440DF39304851D5F6108039A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB3440986863D2893E382BDD02A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+Vrm6g7FZ-PaqLkGfVzN+z8HBTq6Q3MmvR88J6H8cHPw@mail.gmail.com>
 <DM4PR21MB3440D8E8BB2A81C63756AAD6A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB344043ACEFD72B5F0A2A0758A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB344043ACEFD72B5F0A2A0758A35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Jim Harris <jim.harris@gmail.com>
Date:   Thu, 6 Oct 2022 13:44:21 -0700
Message-ID: <CAJP=Hc9NEh+4Dbn-8xuRWcL8usd56JhdxhB64eHqKxJ7Yh+DyQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] ebpf-docs: Improve English readability
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Oct 4, 2022 at 10:09 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> Regarding the tables:
> > Such tables are seen as invaluable for determining correctness of other
> > implementations.   So the feedback is that it's important to have such if we
> > want everyone else to do the right thing.
> >
> > > These people should speak up then.
> >
> > I agree.
>
> Here's two public examples...
>
> Christoph Hellwig, said on May 17 at https://lore.kernel.org/bpf/20220517091011.GA18723@lst.de/:
> > One useful thing for this would be an opcode table with all the
> > optional field usage in machine readable format.
> >
> > Jim who is on CC has already built a nice table off all opcodes based
> > on existing material that might be a good starting point.
>
> Jim Harris responded on that thread with a strawman which was
> used as the basis for the table in the appendix.
>
> Jim then commented in the github version on August 30:
> > In my opinion, this table is the biggest thing that has been missing,
> > and will be most essential for a more "formal" specification.

I think an opcode table is a huge help for developing alternate eBPF
implementations - anything that makes it more explicit which opcodes
are valid (and which ones are not).

For example, the section for BPF_ALU and BPF_ALU64 classes lists the
operation codes.  BPF_END is in that list.  Description says "see
separate section below".  The "Byte swap instructions" section then
says that byte swap instructions always use BPF_ALU, even for 64-bit
widths.  So an implementer can synthesize all of this to determine
that opcodes 0xD7 and 0xDF (which have BPF_ALU64 | BPF_END) are not
valid.  It would be more clear if somewhere there was a list that
explicitly showed that 0xD4 and 0xDC (BPF_ALU | BPF_END) were valid,
but 0xD7 and 0xDF were not.

If there's concern that an appendix gets out of sync with the code and
the primary sections of the instruction set doc, maybe these opcodes
can be added to the existing per-class-code tables in the instruction
set doc.  A full opcode table could probably be generated from those
tables instead of the hand-written one that Dave and I worked on in
his patch.

-Jim


> I will encourage them and others to comment on this thread.
