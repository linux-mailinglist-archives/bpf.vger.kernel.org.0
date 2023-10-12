Return-Path: <bpf+bounces-12029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3E7C6E91
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078C11C2109E
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05226E2E;
	Thu, 12 Oct 2023 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly0QYlmJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3F25107
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 12:54:19 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4AF0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:54:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d3755214dso916027f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115254; x=1697720054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9/OwjmRdTbQ8eXw96KRM4nksnqlfAVP8C3CyB9QmWs=;
        b=ly0QYlmJPO2sa6n40p6YjVH9lwKK1vlQBPqiXzITwMRLJWiMasuptw6GWrWzjs0tts
         0w6i/Lta21DgDPx9aYlzSUES0SeuparGJCNLLyLuTgjX7K6/tjfkQariwvsOB/tIXHmx
         NeqbVi/jvca6WSghEWNQFw3oeNGn5mI2+xsnDjqu7OfXS26eYT7rUdb2PqGuGRu2COzd
         okuY0IoerJ64ZhqILtOX8UNGsP5wjvFFGhhkH3Jsps83dIWEtY1GyyCXtIiGoqjfrN8R
         XhNcBXaerktThZykJwKKiQf1nSWUgVPBkaNY3MfzqTq3ZJQWCBM8XHpcEAN/oOhPDb2x
         qYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115254; x=1697720054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9/OwjmRdTbQ8eXw96KRM4nksnqlfAVP8C3CyB9QmWs=;
        b=VWSMroQ/PEIE1mePeVtcsvY4+baRtO11VNH5k+e/3pxIyGdESBYmglgccNPDJ3U4Ig
         bRCDwf8CQprtKSClygJvJUDrp+Z5+bfMb1ysB7kCWZxgUgD2CGy/q1ZHqd4neR4PPOpG
         WVC5qHseOPPDvoc6ncuQPqFadDKodhqUJgUAChuxFnC2DjkJgnRkq+zCn0tQpT5zs64v
         COQskSDfb6zDcSaDG4HfxMCcAd0sdSvbT4GVCbSVUTxbnc1GpFm9U1vhy8EeZTvF7P5f
         jfJRmbMkcVHSF3sNaUddawTc4GyBN0OwbEblEC0MZCL0RIbw8X2Vb3+lGH9W3ix8hGNr
         O2Jg==
X-Gm-Message-State: AOJu0YyB7Q9IdmBS+jvBOPnAkjeRJwr9fNU5a44DwEnw/Hzssqht9KUN
	qlRRrqDIzFn1EkSBBhR2wE4=
X-Google-Smtp-Source: AGHT+IHkOhsC8hkKQZzWpscIdMw8KZceOpjKfT1TYBjE9L899pPZ9yhMW1vrcpS4sxgy6QiGdKFZNQ==
X-Received: by 2002:adf:fb0b:0:b0:317:6ea5:ab71 with SMTP id c11-20020adffb0b000000b003176ea5ab71mr18890991wrr.30.1697115253537;
        Thu, 12 Oct 2023 05:54:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ba18-20020a0560001c1200b0032d8a4b637bsm3360299wrb.22.2023.10.12.05.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:54:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Oct 2023 14:54:10 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 1/4] btf_encoder, pahole: move btf encoding options
 into conf_load
Message-ID: <ZSfscvIOkikSHc7w@krava>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011091732.93254-2-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:17:29AM +0100, Alan Maguire wrote:
> ...rather than passing them to btf_encoder__new(); this tidies
> up the encoder API and also allows us to use generalized methods
> to translate from a BTF feature (forthcoming) to a conf_load
> parameter.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

nice cleanup

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  btf_encoder.c |  8 ++++----
>  btf_encoder.h |  2 +-
>  dwarves.h     |  3 +++
>  pahole.c      | 21 ++++++++-------------
>  4 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 65f6e71..fd04008 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1625,7 +1625,7 @@ out:
>  	return err;
>  }
>  
> -struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
> +struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
>  {
>  	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
>  
> @@ -1639,9 +1639,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		if (encoder->btf == NULL)
>  			goto out_delete;
>  
> -		encoder->force		 = force;
> -		encoder->gen_floats	 = gen_floats;
> -		encoder->skip_encoding_vars = skip_encoding_vars;
> +		encoder->force		 = conf_load->btf_encode_force;
> +		encoder->gen_floats	 = conf_load->btf_gen_floats;
> +		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/btf_encoder.h b/btf_encoder.h
> index 34516bb..f54c95a 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -16,7 +16,7 @@ struct btf;
>  struct cu;
>  struct list_head;
>  
> -struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
> +struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
>  void btf_encoder__delete(struct btf_encoder *encoder);
>  
>  int btf_encoder__encode(struct btf_encoder *encoder);
> diff --git a/dwarves.h b/dwarves.h
> index eb1a6df..db68161 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -68,6 +68,9 @@ struct conf_load {
>  	bool			skip_encoding_btf_enum64;
>  	bool			btf_gen_optimized;
>  	bool			skip_encoding_btf_inconsistent_proto;
> +	bool			skip_encoding_btf_vars;
> +	bool			btf_gen_floats;
> +	bool			btf_encode_force;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index e843999..7a41dc3 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -32,13 +32,10 @@
>  static struct btf_encoder *btf_encoder;
>  static char *detached_btf_filename;
>  static bool btf_encode;
> -static bool btf_gen_floats;
>  static bool ctf_encode;
>  static bool sort_output;
>  static bool need_resort;
>  static bool first_obj_only;
> -static bool skip_encoding_btf_vars;
> -static bool btf_encode_force;
>  static const char *base_btf_file;
>  
>  static const char *prettify_input_filename;
> @@ -1786,9 +1783,9 @@ static error_t pahole__options_parser(int key, char *arg,
>  	case ARGP_header_type:
>  		conf.header_type = arg;			break;
>  	case ARGP_skip_encoding_btf_vars:
> -		skip_encoding_btf_vars = true;		break;
> +		conf_load.skip_encoding_btf_vars = true;	break;
>  	case ARGP_btf_encode_force:
> -		btf_encode_force = true;		break;
> +		conf_load.btf_encode_force = true;	break;
>  	case ARGP_btf_base:
>  		base_btf_file = arg;			break;
>  	case ARGP_kabi_prefix:
> @@ -1797,9 +1794,9 @@ static error_t pahole__options_parser(int key, char *arg,
>  	case ARGP_numeric_version:
>  		print_numeric_version = true;		break;
>  	case ARGP_btf_gen_floats:
> -		btf_gen_floats = true;			break;
> +		conf_load.btf_gen_floats = true;	break;
>  	case ARGP_btf_gen_all:
> -		btf_gen_floats = true;			break;
> +		conf_load.btf_gen_floats = true;	break;
>  	case ARGP_with_flexible_array:
>  		show_with_flexible_array = true;	break;
>  	case ARGP_prettify_input_filename:
> @@ -3063,8 +3060,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  			 * And, it is used by the thread
>  			 * create it.
>  			 */
> -			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
> -						       btf_encode_force, btf_gen_floats, global_verbose);
> +			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf,
> +						       global_verbose, conf_load);
>  			if (btf_encoder && thr_data) {
>  				struct thread_data *thread = thr_data;
>  
> @@ -3093,10 +3090,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  				thread->encoder =
>  					btf_encoder__new(cu, detached_btf_filename,
>  							 NULL,
> -							 skip_encoding_btf_vars,
> -							 btf_encode_force,
> -							 btf_gen_floats,
> -							 global_verbose);
> +							 global_verbose,
> +							 conf_load);
>  				thread->btf = btf_encoder__btf(thread->encoder);
>  			}
>  			encoder = thread->encoder;
> -- 
> 2.31.1
> 

