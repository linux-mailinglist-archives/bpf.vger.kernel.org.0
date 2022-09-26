Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13D25E9710
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIZAK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIZAK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 20:10:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550C24BD1;
        Sun, 25 Sep 2022 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664151024; x=1695687024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=47gt1TEuPE8j169uNoQ5XLe249DFPFUls31iYOWmThs=;
  b=EzYCOOtDhjk5Tp9vv03jwRek3NmJNCZ7PNGBQAzVeQy21e3WpCRx6MHg
   9sCac9XY7zjP4HnZTrjg1aCOrJJn9NOLb2f3cqWLgNJ6cVzHGSAOQEVTA
   kH6TgGTSgxGgVz0LonweFMyvhhL9a8kTkc5S9FAx49bC528adrkthN+6k
   I0pDqr79XmviKJBl/UNNZ5bV11Qf+sQTunUyjZu/fjQE7S6KXo3w0jssI
   Ifgkk+LzxNLtqehcqwb+9aHtheigxRLeU3Xu43GO3OBXapi08aRO1L4TJ
   Vckjdy1LxRNeFUO+SHRHczy7ItXseOwFjot93Qytl0e6KCeZrFybBPSfQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="364938685"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="364938685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 17:10:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="763247523"
Received: from obyrd-mobl2.amr.corp.intel.com (HELO [10.212.210.57]) ([10.212.210.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 17:10:21 -0700
Message-ID: <a2673df8-cf8a-b94a-68cd-1e2777fb5cf4@intel.com>
Date:   Sun, 25 Sep 2022 17:10:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board@lists.linuxfoundation.org,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Cc:     Borislav Petkov <bp@alien8.de>, brijesh.singh@amd.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jane.chu@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, seanjc@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
References: <00000000000076f3a305e97e9229@google.com>
 <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
 <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/25/22 14:55, Alexei Starovoitov wrote:
> And, sorry, "flip ro/rw every time" is not a good idea from
> security pov.
> There is a much better solution that stalled on the code review.
> In the meantime we'll land a quick fix to re-enable boot in -next
> in the coming days.

Peter, I remember an earlier version of your patch having some various
enforcement modes.  Since the strict enforcement has actually broken a
few things, should we resurrect the nicer soft detection mode?  Or,
maybe make the soft one the only mode for now?

Alexei, the "quick fix" looks sane to me at first glance.  Is there
something in there that's not viable long-term?

Also, the intention here was not to force any issues.  I thought the
earlier discussion resulted in a bpf fix and applying Peter's patch was
intended to catch _future_ issues.  I should have double-checked before
applying it.  My apologies.
