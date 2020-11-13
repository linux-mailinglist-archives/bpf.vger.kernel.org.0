Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1F2B236A
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKMSLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 13:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgKMSLm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 13:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605291100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbueKtZO3RwBSx69HdMieYHAMJKIIZcrmcWgwb/21SE=;
        b=K67VnFg2HzDhLQglesv6xANX7ktOAsenT3xJTfp5MAjhG76eToRyQByn7teWXguyHtlaRo
        SXaeaA/qx5Fgqd/Ye7eLhrZIEImnLF05eDAQr7RtgPJ4j2xPCIOYnaRBGhuSO1J+SA5qSj
        tvk8G9Nr1ClCgryHFd9YAUdWK4LsGJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-OvwfXRErOu-7Y3S2zHjOdA-1; Fri, 13 Nov 2020 13:11:37 -0500
X-MC-Unique: OvwfXRErOu-7Y3S2zHjOdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13BF87950B;
        Fri, 13 Nov 2020 18:11:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8EC8E5D9F1;
        Fri, 13 Nov 2020 18:11:33 +0000 (UTC)
Date:   Fri, 13 Nov 2020 19:11:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/2] btf_encoder: Fix function generation
Message-ID: <20201113181132.GB842058@krava>
References: <20201113151222.852011-1-jolsa@kernel.org>
 <20201113151222.852011-3-jolsa@kernel.org>
 <20201113172832.GA446420@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172832.GA446420@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 02:28:32PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 13, 2020 at 04:12:22PM +0100, Jiri Olsa escreveu:
> > Current conditions for picking up function records break
> > BTF data on some gcc versions.
> > 
> > Some function records can appear with no arguments but with
> > declaration tag set, so moving the 'fn->declaration' in front
> > of other checks.
> > 
> > Then checking if argument names are present and finally checking
> > ftrace filter if it's present. If ftrace filter is not available,
> > using the external tag to filter out non external functions.
> 
> Humm has_arg_names() will return true for a:
> 
> void foo(void)
> 
> function, which I think is right, but can't this function appear
> multiple times in different CUs and we end up with the same function
> multiple times in the BTF info?

so declarations should be filtered by the fn->declaration
check, if gcc has it ;-)

and if it goes through, the should_generate_function sets/checks
flag if the function was already generated

jirka

> 
> - Arnaldo
>  
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index d531651b1e9e..de471bc754b1 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -612,25 +612,21 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >  		const char *name;
> >  
> >  		/*
> > -		 * The functions_cnt != 0 means we parsed all necessary
> > -		 * kernel symbols and we are using ftrace location filter
> > -		 * for functions. If it's not available keep the current
> > -		 * dwarf declaration check.
> > +		 * Skip functions that:
> > +		 *   - are marked as declarations
> > +		 *   - do not have full argument names
> > +		 *   - are not in ftrace list (if it's available)
> > +		 *   - are not external (in case ftrace filter is not available)
> >  		 */
> > +		if (fn->declaration)
> > +			continue;
> > +		if (!has_arg_names(cu, &fn->proto))
> > +			continue;
> >  		if (functions_cnt) {
> > -			/*
> > -			 * We check following conditions:
> > -			 *   - argument names are defined
> > -			 *   - there's symbol and address defined for the function
> > -			 *   - function address belongs to ftrace locations
> > -			 *   - function is generated only once
> > -			 */
> > -			if (!has_arg_names(cu, &fn->proto))
> > -				continue;
> >  			if (!should_generate_function(btfe, function__name(fn, cu)))
> >  				continue;
> >  		} else {
> > -			if (fn->declaration || !fn->external)
> > +			if (!fn->external)
> >  				continue;
> >  		}
> >  
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 

