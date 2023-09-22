Return-Path: <bpf+bounces-10653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9437AB973
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2241B1C20A9F
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8043693;
	Fri, 22 Sep 2023 18:42:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CB1C29
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 18:42:31 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9DA9;
	Fri, 22 Sep 2023 11:42:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-532c66a105bso3054534a12.3;
        Fri, 22 Sep 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695408148; x=1696012948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A07py4MTlmtIRoHDL+wrJZuQS+RAbNl3SUABDDToi9g=;
        b=lbI5k+/gyR4nsvGKGxtc7PY4jdOLk0VIA7k/HjMup0Rd6CbZfMjMZsrIhYZvPT7l7P
         e/CKbcN9vPweVOEi7u3zWBKKTl1AcMv85o2epKEWNXibWv/5e89TICUsmLaYyQXslYvt
         lP/7DQKHg+wByXmyBvVVqsI7a5NEbDFMUeNF6Ss0WEi1/G50N73XF9wyJv4Q8iTxFfcp
         /MqafQvQ/WVRR634CrgYK4/3FbUDz/R9VYdKbrAyBL72zXnem/wXOiaeZ1VirH+qtwXo
         FtvFASfoJBiAROUCSFEMtnQQjxqca/e0eL5N/F5EEBpqTHTDUmM/alD8iD3u39TbuDsk
         vALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408148; x=1696012948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A07py4MTlmtIRoHDL+wrJZuQS+RAbNl3SUABDDToi9g=;
        b=ShPBoIm3I/fUdog0C7bo2bULhdTa3CCUg0ULPsKhNXyrDOsUgvmgaou3o959bLRgqH
         RMd0VDBs0HctLamfPQG7W6BEu9Fk8uGLYx+OAvFuiy2lE7ZNd+TtX37cw4cjOnkLZsWW
         6CPdn+QuWo8psLMDIv5oV88wWLYzrTaAcdhjkUlwagK16a/HtBLB3ueFyh5VSwqlXzMw
         BMC+DbqLE7gPWSMdnBiLVmAqkz6Bt0kLoj54/eZQVh9cUUwg4mbIbVBwWL7UBRhiu6Oh
         ag2TeQvRkEH+qRSgowuJ+QnUc+vG0wTsvbF/sOSKpZQkRJ/oMt+hvoWSoDacHPhV753A
         jy8w==
X-Gm-Message-State: AOJu0Yze1q3vpsLVmKizfGfZio6zZ2m3xABqN0PWfdoH7F+FTBMxFpAF
	XVxDUYwFWTy+iet5bCyP9Ms=
X-Google-Smtp-Source: AGHT+IGAXpsGQGhQAXFNELhiI7tG9YTVnUt0vp01z0qFoa9vgsCbFmzQ0pGhjEszK3XUaBkCBTSscg==
X-Received: by 2002:a17:906:28d:b0:9b0:169b:eece with SMTP id 13-20020a170906028d00b009b0169beecemr213729ejf.40.1695408148133;
        Fri, 22 Sep 2023 11:42:28 -0700 (PDT)
Received: from f (cst-prg-31-165.cust.vodafone.cz. [46.135.31.165])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009a1be9c29d7sm3079107ejb.179.2023.09.22.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:42:27 -0700 (PDT)
Date: Fri, 22 Sep 2023 20:42:24 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <20230922184224.kx4jiejmtnvfrxrq@f>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-1-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> Since we know the address of the enabled LSM callbacks at compile time and only
> the order is determined at boot time, the LSM framework can allocate static
> calls for each of the possible LSM callbacks and these calls can be updated once
> the order is determined at boot.
> 

Any plans to further depessimize the state by not calling into these
modules if not configured?

For example Debian has a milipede:
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

Everything is enabled (but not configured).

In particular tomoyo is quite nasty, rolling with big memsets only to
find it is not even enabled.

