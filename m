Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F293367B9FA
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjAYS4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYS4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:56:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D22AAD3C
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE626155C
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 18:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11553C433EF;
        Wed, 25 Jan 2023 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674672993;
        bh=joDekU6gG2sQaRZOIo6Di+DGJAdfqIt5Y6MtKul2kvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMKk90bboeUEmq6m0CkELYenlUuEiN5anskHoCxaNq8Sieh3SUKo1OHWEc/bS/dH0
         5K9RCZlStvwdNkQTs22aoO1VALWrwgHd2Y2Uqg4NT6t+/hxh1ow+/imwLz1j22SMn4
         q3Qd3twzc2CXQl517lG7U3KBHnV0Qx69nLKSbJMbDmgbXl2b2r1IdoyoI96ba6FPJr
         slEikIe2+gD8cUd2wreHeAbeORYEJWcuHeCuMlvi6RuqPs6ydeQ75hTBVkBzHU6Qyn
         DzQGLiHE6Zp4OEFyB0Uv0mkEV6QDnzjpRQc+Gl4QGzGXkVoMP/3sS9SVTFWxNI312T
         gihHqK9KDxelQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B73B405BE; Wed, 25 Jan 2023 15:56:30 -0300 (-03)
Date:   Wed, 25 Jan 2023 15:56:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kui-Feng Lee <sinquersw@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, yhs@fb.com, ast@kernel.org,
        olsajiri@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 4/5] btf_encoder: represent "."-suffixed
 optimized functions (".isra.0") in BTF
Message-ID: <Y9F7Xt7Kt463kh6L@kernel.org>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
 <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 25, 2023 at 09:54:26AM -0800, Kui-Feng Lee escreveu:
> 
> On 1/24/23 05:45, Alan Maguire wrote:
> > +/*
> > + * static functions with suffixes are not added yet - we need to
> > + * observe across all CUs to see if the static function has
> > + * optimized parameters in any CU, since in such a case it should
> > + * not be included in the final BTF.  NF_HOOK.constprop.0() is
> > + * a case in point - it has optimized-out parameters in some CUs
> > + * but not others.  In order to have consistency (since we do not
> > + * know which instance the BTF-specified function signature will
> > + * apply to), we simply skip adding functions which have optimized
> > + * out parameters anywhere.
> > + */
> > +static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
> > +{
> > +	struct btf_encoder *parent = encoder->parent ? encoder->parent : encoder;
> > +	const char *name = function__name(fn);
> > +	struct function **nodep;
> > +	int ret = 0;
> > +
> > +	pthread_mutex_lock(&parent->saved_func_lock);
> 
> Do you have the number of static functions with suffices?

⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | grep '[[:alnum:]]\.' | wc -l
7245
⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | wc -l
122336
⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | grep '[[:alnum:]]\.constprop' | wc -l
1292
⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | grep '[[:alnum:]]\.isra' | wc -l
1148
⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | grep '[[:alnum:]]\.cold' | wc -l
4066
⬢[acme@toolbox linux]$ readelf -sW ../build/v6.2-rc5+/vmlinux | grep -w FUNC | grep '[[:alnum:]]\.part' | wc -l
1013
⬢[acme@toolbox linux]$
 
> If the number of static functions with suffices is high, the contention of
> the lock would be an issue.
> 
> Is it possible to keep a local pool of static functions with suffices? The
> pool will be combined with its parent either at the completion of a CU,
> before ending the thread or when merging into the main thread.

May help, but I think maybe premature optimization is the root of... :-)

- Arnaldo
 
> > +	nodep = tsearch(fn, &parent->saved_func_tree, function__compare);
> > +	if (nodep == NULL) {
> > +		fprintf(stderr, "error: out of memory adding local function '%s'\n",
> > +			name);
> > +		ret = -1;
> > +		goto out;
> > +	}
> > +	/* If we find an existing entry, we want to merge observations
> > +	 * across both functions, checking that the "seen optimized-out
> > +	 * parameters" status is reflected in our tree entry.
> > +	 * If the entry is new, record encoder state required
> > +	 * to add the local function later (encoder + type_id_off)
> > +	 * such that we can add the function later.
> > +	 */
> > +	if (*nodep != fn) {
> > +		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
> > +	} else {
> > +		struct btf_encoder_state *state = zalloc(sizeof(*state));
> > +
> > +		if (state == NULL) {
> > +			fprintf(stderr, "error: out of memory adding local function '%s'\n",
> > +				name);
> > +			ret = -1;
> > +			goto out;
> > +		}
> > +		state->encoder = encoder;
> > +		state->type_id_off = encoder->type_id_off;
> > +		fn->priv = state;
> > +		encoder->saved_func_cnt++;
> > +		if (encoder->verbose)
> > +			printf("added local function '%s'%s\n", name,
> > +			       fn->proto.optimized_parms ?
> > +			       ", optimized-out params" : "");
> > +	}
> > +out:
> > +	pthread_mutex_unlock(&parent->saved_func_lock);
> > +	return ret;
> > +}
> > +

-- 

- Arnaldo
