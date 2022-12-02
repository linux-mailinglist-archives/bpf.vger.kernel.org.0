Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65541640C5C
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiLBRn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiLBRn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 12:43:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF22F390
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 09:43:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670003035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw2IcvB/DAxzATKFNjZzen0qSXdeIAQcVISV0zMHhRs=;
        b=vqme40fhzHor+wxF288mCsnY/rm6HPnwOtK75h/AeGYp4SFl6C/3snqM9dT0eV3WQmSdsT
        VfjwQCE0VBa+/DFXJrs79iydgOg8RaMVGRQe7AxhMRhDbMhM901pecVQ8quvcvBgSucYCO
        6tyLkb9TENNC3eqAxQgghambuYEplJSKQmyshoEE9oQpoJQD9z969tSvYzn3BXyNuhVzdW
        c2byKk68jrgUaAwQuE0nwW+YvTNHEglVSW0CCy26zZ17G+VFO0S74pcfemmdqzoaP/fn8b
        iUaRUFkRhaHiPcht1fPOQE/zYqppMouty6V8MvZukGQAUbkTebm0pOyu90oAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670003035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hw2IcvB/DAxzATKFNjZzen0qSXdeIAQcVISV0zMHhRs=;
        b=XWZ8S6H/jSo4nTycZl9+k8Sdnrgh80/yWstyPolb2XirRQQQ1dTKWKS7njbVcaks4RAc9v
        oEa7doqyBKP0EMAQ==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <5fb21965-48c8-e795-632a-fa190470abe8@csgroup.eu>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx> <5fb21965-48c8-e795-632a-fa190470abe8@csgroup.eu>
Date:   Fri, 02 Dec 2022 18:43:54 +0100
Message-ID: <87ilitpup1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 02 2022 at 10:46, Christophe Leroy wrote:
> Le 02/12/2022 =C3=A0 02:38, Thomas Gleixner a =C3=A9crit=C2=A0:
>> Even modules can benefit from that. The fact that modules have all
>> sections (text, data, rodata) page aligned and page granular is not due
>> to an requirement of modules, it's so because that's how module_alloc()
>> works and the module layout has been adopted to it.
>
> Sections are page aligned only when STRICT_MODULE_RWX is selected.

Correct, but without strict permission separation we would not debate
this at all. Everything would be RWX and fine.

For separation my point still stands that the problem is that
module_alloc() is just doing an en-bloc allocation, which needs to be
split into RX, RW, RO afterwards and that consequently splits the large
mappings apart. Which in turn means text, data, rodata have to be page
aligned and page granular.

The typed approach and having a mechanism to preserve the underlying
large page mappings is the broadest scope we have to cover.

An RWX only architecture is just the most trivial case of such an
infrastructure. The types become all the same, the underlying page size
does not matter, but it's just a configuration variant.

Architectures which support strict separation, but only small pages are
a configuration variant too.

All of them can use the same infrastructure and the same API to
alloc/free and write/update the allocated memory. The configuration will
take care to pick the appropriate mechanisms.

No?

Thanks,

        tglx

=20
