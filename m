Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44D587994
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiHBJGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHBJGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 05:06:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E11F2F3;
        Tue,  2 Aug 2022 02:06:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kb8so10237056ejc.4;
        Tue, 02 Aug 2022 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=V8gYa+sBiTGdjjR/vK84132IAMoTr3+9+KBnD1O06nE=;
        b=pPqkMLt43zhJxSYfeIBgY5x7VroKNnvMivbgPS58Bv1VAJ65jaRyYyT1v88VdMmhaJ
         p4GvrNO50B3ZFbzCW+vugW75ZTEw1+oCtb41mqo4yP9yFQfSUcK91y52wzE35AyIsSf3
         G72lYCESRznPDaP1ZjW5SursV/nIBAk8V5850ZONvT5W3PmPEg6burgMgK6jdGR5mhVu
         RVgiBvPACIsKAs1QzfgncfsSJ9e3Dhb1REMRDTO3GvHCmXertG5zjwrr9YLcAJN4+DWs
         NlfvvADpRf16ePfQcOaFC5WZqql1DmiqIAZBB96l9dDi/VCzNvz0ppROMKeLI4IWUuJX
         OFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=V8gYa+sBiTGdjjR/vK84132IAMoTr3+9+KBnD1O06nE=;
        b=vNsypET/E7pnBncWcm/88AJod9C4b9H0qiCu/0oDtrsvDUmr5u893JYCMvv5KvG9Hc
         uADGkzCvb6gRsHmqKPewQSDqZQfl8N82mnCF5YfST7sy0v2N1Ofd27rRnHEkz9CDtw/v
         SzkIvwF1C4pc1oyrZMBwEj8byvFePVSmsdQxFV+G4sLdvkkQjaA3EN0R5KJdfPgr3mhQ
         ig4u4anCA6Pje0r5Z7xlpi6aLNM3Zcj0o95Dmx/icSoTiocNrRJQ66aNbW348lNSvcI1
         a2c4Jqg4BuoyRQEcru9pR5KlRG3rJA3rZubz1xxIaH+rN5+r+fHzKFXiBqdyNIPLCRc2
         HRpA==
X-Gm-Message-State: AJIora8BpwrpTMqw9YKYHCaux6d4nDygHxNvDKDzqg+Tpt/tADIlOoK2
        W4dmaXXe+L9x1q56n0mtiI0=
X-Google-Smtp-Source: AGRyM1sPmP16v8BlQ+4t0ux1CrIzduOFP9FqkF0X1wwIL3cwna8RDtSm+P3GVuGgwKhGpKTX/y7g9w==
X-Received: by 2002:a17:906:6c82:b0:709:f868:97f6 with SMTP id s2-20020a1709066c8200b00709f86897f6mr15071129ejr.555.1659431191492;
        Tue, 02 Aug 2022 02:06:31 -0700 (PDT)
Received: from krava ([83.240.61.12])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b0043cf1c6bb10sm7926070edr.25.2022.08.02.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:06:31 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 2 Aug 2022 11:06:29 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, peterz@infradead.org,
        mingo@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Message-ID: <YujpFUB8KlkOgzyb@krava>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
 <Yug6bx7T4GzqUf2a@krava>
 <20220801165146.26fdeca2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801165146.26fdeca2@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 04:51:46PM -0400, Steven Rostedt wrote:
> On Mon, 1 Aug 2022 22:41:19 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > LGTM cc-ing Steven because it affects ftrace as well
> 
> Thanks for the Cc, but I don't quite see how it affects ftrace.
> 
> Unless you are just saying how it can affect kprobe_events?

nope, I just saw the 'ftrace' in changelog ;-)

anyway the patch makes check_kprobe_address_safe to fail
on ftrace trampoline address.. but not sure you could make
kprobe on ftrace trampoline before, probably not

jirka

> 
> -- Steve
> 
> 
> > 
> > jirka
> > 
> > > 
> > > v1 -> v2:
> > > Check core_kernel_text and is_module_text_address rather than
> > > only kprobe_insn.
> > > Also fix title and commit message for this. See old patch at [1].
> > > ---
> > >  kernel/kprobes.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index f214f8c088ed..80697e5e03e4 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > >  	preempt_disable();
> > >  
> > >  	/* Ensure it is not in reserved area nor out of text */
> > > -	if (!kernel_text_address((unsigned long) p->addr) ||
> > > +	if (!(core_kernel_text((unsigned long) p->addr) ||
> > > +	    is_module_text_address((unsigned long) p->addr)) ||
> > >  	    within_kprobe_blacklist((unsigned long) p->addr) ||
> > >  	    jump_label_text_reserved(p->addr, p->addr) ||
> > >  	    static_call_text_reserved(p->addr, p->addr) ||
> > > -- 
> > > 2.17.1
> > >   
> 
