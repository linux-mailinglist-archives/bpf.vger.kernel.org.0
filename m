Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AEC6A8C07
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCBWjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCBWjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:39:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48F1C7FA
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 14:39:19 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so826507plz.8
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677796759;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ve+BiqrVh3y2CLEyQTfU5TVBLSO2fLvwSbHEFg94q/U=;
        b=FkZZW3E/sW6zViGZ7A6SBOLIdPKkwdSQQlVCinvWm3pJKL8gM1m23FSPZ5maCFMBut
         RQZ/y3AAwqlNcWxTmWeTxCvCn2wApj7em9BnMtv6oeS1IZztHysmjew11Qc2Eh/lCdk/
         n/lOswnqPj02B2coQREOabxS8YZZCKtPfvlZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796759;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve+BiqrVh3y2CLEyQTfU5TVBLSO2fLvwSbHEFg94q/U=;
        b=sbWA50JHn+WOg4EZJah/AfnueotS8JtU1YWS/i/jtYZilNPxVPCCLfuK5HbCr/txuE
         W1PB7r+/Qg+zXThphiei7wygQAjl4CUA9W6E2OeVcTnMP+QTJJqRslp7j2kHSnC1amoz
         jeiI7l40EHHFsONgkSejIDOrXaQ9neThbv9W33ZabphZt0VBSYALZfN7Dyj8XObTSEw8
         ub+k1dX07h2KjKjiq91RSj3HZypnomsClKufhdoGHe1XnpOEKZsR3Tawu6nZtu576rKs
         PlKOvawbSDTpYtyQvSO0dmBaDk/Otk6gF0HeOGoxyY5E6/KJm3O6jNEnm3aceUrWzBcB
         3lug==
X-Gm-Message-State: AO0yUKXxkF+dqIMepNmmXPsxPq76edEWFOGleaX3sflzq+ZYK1sEi7is
        tRj2U58FQvD0y6QSJPuP207HZA==
X-Google-Smtp-Source: AK7set/4Xvl/HFOsgacZB5FbbhSUUYLql+pvMqp3Sq4140/+vvvbQGP7fqMVhvfIVPCoRgOum8Ox4Q==
X-Received: by 2002:a17:902:dad1:b0:19c:d32a:befc with SMTP id q17-20020a170902dad100b0019cd32abefcmr13051964plx.15.1677796758881;
        Thu, 02 Mar 2023 14:39:18 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b0019a70a42b0asm168526plp.169.2023.03.02.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:39:18 -0800 (PST)
Message-ID: <64012596.170a0220.1940.0a34@mx.google.com>
X-Google-Original-Message-ID: <202303021434.@keescook>
Date:   Thu, 2 Mar 2023 14:39:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: splat in ikheaders_read (bpftrace)
References: <20230302112130.6e402a98@kernel.org>
 <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
 <20230302140814.294aece0@kernel.org>
 <20230302141231.2c0a3761@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302141231.2c0a3761@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 02:12:31PM -0800, Jakub Kicinski wrote:
> On Thu, 2 Mar 2023 14:08:14 -0800 Jakub Kicinski wrote:
> > > static ssize_t
> > > ikheaders_read(struct file *file,  struct kobject *kobj,
> > > 	       struct bin_attribute *bin_attr,
> > > 	       char *buf, loff_t off, size_t len)
> > > {
> > > 	memcpy(buf, &kernel_headers_data + off, len);
> > > 	return len;
> > > }
> > > 
> > > I will take a look at the caller's allocation of "buf" and kernel_headers_data.  
> > 
> > Mm. Actually stopping to look at the code - I don't see it bound
> > checking against kernel_headers_data_end :| Maybe we need:
> > 
> > @@ -34,6 +35,7 @@ ikheaders_read(struct file *file,  struct kobject *kobj,
> >                struct bin_attribute *bin_attr,
> >                char *buf, loff_t off, size_t len)
> >  {
> > +       len = min_t(size_t, kernel_headers_data_end - kernel_headers_data, len);
> >         memcpy(buf, &kernel_headers_data + off, len);
> >         return len;
> >  }
> 
> Scratch that, the size is set at init time.
> My guess was memcpy() thinks the size of kernel_headers_data
> is 1 since it's declared as char?

I've improved the reporting, and yeah, it's due to the declaration:

  memcpy: detected buffer overflow: 4096 byte read from buffer of size 1

But that's an easy fix -- this has been done in lots of other places. It
needs to be an array, not a single char. (I'm surprised we hadn't seen
this before.)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..42163c9e94e5 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,15 +26,15 @@ asm (
 "	.popsection				\n"
 );
 
-extern char kernel_headers_data;
-extern char kernel_headers_data_end;
+extern char kernel_headers_data[];
+extern char kernel_headers_data_end[];
 
 static ssize_t
 ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
 
@@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
 
 static int __init ikheaders_init(void)
 {
-	kheaders_attr.size = (&kernel_headers_data_end -
-			      &kernel_headers_data);
+	kheaders_attr.size = (kernel_headers_data_end -
+			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 


-- 
Kees Cook
