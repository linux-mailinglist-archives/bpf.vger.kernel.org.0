Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7E575C24
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGOHJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGOHJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 03:09:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5E7E037;
        Fri, 15 Jul 2022 00:07:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sz17so7383269ejc.9;
        Fri, 15 Jul 2022 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4cKHpBX3GKYfo31YrNMD3XtQnzpsZ4HK4/N3cEmwrFE=;
        b=d6o1HwZwKOS3HdpkxBaTdjWvUmXJ/N3uf2KyjwbVCHnvfWiJApIHhvy9Xhe85/fbXi
         tuyVPQXXrdXVxbJNFYSQm4ofDdDlnzG8t9Ei4+bNJJrUv3QaTyouyIlHg8YRuTqrj6qr
         tN/59omlcPFa59fbibeEhUq2u6Ra8w8p+4K+V+b/aHWZHsdhSCpWJooxkxTZtYbxbKPu
         QaPyE/Jz5+UpKxPqriA1h8w5cHTMjL71LrvgpRLTSK2eEW8XvQG40tiy4RiiJH0Qhwzn
         LaRLuhjKNVug4xDcYryryJiGTHlctIbhO3bEE3rAmS14cCGJ1BIPyzCrOPZq9sdH9DSw
         0MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4cKHpBX3GKYfo31YrNMD3XtQnzpsZ4HK4/N3cEmwrFE=;
        b=aDotE99YME9At6T1TtEn1qvTREvnmkIj1UYWukmxSJT53phXC1CrepJqD1FMvIsra1
         leYIHIUoAJUwiY8zhnt6thzb5qruTFxHtQihH4F+KOBGWWWR8fNBEY2Zz4C4YHpaimoJ
         HpZsY+ljaH/mmewNcjnLrWuX+FhL0qIp6zqleshdYJ34eUHRk+VuzEuRvxHnR4fqZ592
         AprIlaHgLHkqGIX6KnxQ3Z0dABivl1y+eFRBG6IyL+d7p0or6KE9MupzUMk+gBzESA6c
         vNzLZOfup2AaYTn9oAL1q3yngnDjE+6kfOXSDNBk3Pkd6PMQW/0b3Il3VcEbbDHTuwr7
         GO0Q==
X-Gm-Message-State: AJIora/o9o1Vwrcn3DnRxEmnh6FwTQpFjoLxE49/TQCIZlK0pCXANHNw
        D6zAq2ujcpizqdfwqFCPZoo=
X-Google-Smtp-Source: AGRyM1sjfZ2tJrWkKH7wtY2WyB4CR8AW3KVvmZZ55SkF8GrLTBS1g66mSo6ISat58lL2WHEcG1I20Q==
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id jz15-20020a17090775ef00b0072b02fd1a92mr12203006ejc.745.1657868865486;
        Fri, 15 Jul 2022 00:07:45 -0700 (PDT)
Received: from laptop ([77.222.6.10])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709061f0200b0072b1e27888asm1665294ejj.50.2022.07.15.00.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:07:45 -0700 (PDT)
Date:   Fri, 15 Jul 2022 09:07:42 +0200
From:   Fedor Tokarev <ftokarev@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Fedor Tokarev <ftokarev@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: btf: Fix vsnprintf return value check
Message-ID: <20220715070742.GA165641@laptop>
References: <20220711211317.GA1143610@laptop>
 <YsyZY/tFm3hi5srl@krava>
 <CAEf4BzYGjNaqL4h8=4Jw7O_xxMfy=TbUg94VO6RZT5wOtV+_wQ@mail.gmail.com>
 <ef44abe0-81fc-9c97-a4e4-2b3ba19cd84f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef44abe0-81fc-9c97-a4e4-2b3ba19cd84f@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 11:06:22AM +0100, Alan Maguire wrote:
> On 13/07/2022 19:40, Andrii Nakryiko wrote:
> > On Mon, Jul 11, 2022 at 2:45 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>
> >> On Mon, Jul 11, 2022 at 11:13:17PM +0200, Fedor Tokarev wrote:
> >>> vsnprintf returns the number of characters which would have been written if
> >>> enough space had been available, excluding the terminating null byte. Thus,
> >>> the return value of 'len_left' means that the last character has been
> >>> dropped.
> >>
> >> should we have test for this in progs/test_snprintf.c ?
> > 
> > It might be too annoying to set up such test, and given the fix is
> > pretty trivial IMO it's ok without extra test. But cc Alan for ack.
> > Alan, please take a look as well.
> > 
> 
> I can follow up with a test, it should be okay I think (we can use
> the "don't show types" flag and tryp to print "10" with a 2-byte len or
> similar).

I'll gladly give it a try.

> In terms of the fix, it looks good, but given that the code is tricky, 
> it might be good to expand a bit on the explanation. Something like the below?
> 
Agreed.

> "When using btf_type_snprintf_show(), the user passes in a "len" value, and
> we use it to initialize ssnprintf.len_left, indicating how much space
> remains for the string representation, including the null byte, so "len - 1" 
> bytes are actually available for the actual string data, leaving one for 
> the terminating null byte.
> 
> In btf_snprintf_show() - which is passed the ssnprintf data as an argument -
> vsnprintf() returns the len that would have been written, and this _excludes_ 
> the null terminator. But we want to handle cases where the length of the string
> to be written (excluding the null terminator) exactly matches the original len 
> value we passed in (len == len_left) in the same way was we do other
> overflow cases (len > len_left)."
> 
> Acked-by: Alan Maguire <alan.maguire@oracle.com>
> 
> >>
> >> jirka
> >>
> >>>
> >>> Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
> >>> ---
> >>>  kernel/bpf/btf.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>> index eb12d4f705cc..a9c1c98017d4 100644
> >>> --- a/kernel/bpf/btf.c
> >>> +++ b/kernel/bpf/btf.c
> >>> @@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> >>>       if (len < 0) {
> >>>               ssnprintf->len_left = 0;
> >>>               ssnprintf->len = len;
> >>> -     } else if (len > ssnprintf->len_left) {
> >>> +     } else if (len >= ssnprintf->len_left) {
> >>>               /* no space, drive on to get length we would have written */
> >>>               ssnprintf->len_left = 0;
> >>>               ssnprintf->len += len;
> >>> --
> >>> 2.25.1
> >>>
