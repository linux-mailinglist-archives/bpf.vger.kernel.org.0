Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2650EFA1
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 06:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiDZEPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 00:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiDZEPa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 00:15:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE117E0D;
        Mon, 25 Apr 2022 21:12:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so1370718pjf.3;
        Mon, 25 Apr 2022 21:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgY8JDNp96/PZ9zGZDqtUD86gS1yTV51Snpcd+6jrVQ=;
        b=ShU3zbaOSjlfnuQzRkOtr1157n/MdxFknpUh9Gyg1dcFTnM9GB09A5Aakp/djXa6PE
         1dVyV+xPEexa7fDaoFcK/dTIOOFammE9xG7cV4sgDCffSEUw/ygrx9PNH5VOmGI9fz0J
         yM6YMlg8JLtZSRNmW2K6lNUm82Q+KXI4kr45d0FsxUAEoZnsE6pfhylLvdkMQx3/C36K
         hKDquGbIQf5DjPcrqcLjJqfbLjvOAqFH1N5SOAR+SeJJwE8s8TK4lCeZnZyc+W76A2sD
         knylmaO540ZXLJeGQdker0LNMGQlA4oTFx9pQ0X6fRZ20kEp8A1OTNoxGeoT0yov4FCd
         Aw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgY8JDNp96/PZ9zGZDqtUD86gS1yTV51Snpcd+6jrVQ=;
        b=0ioujO/AmTt2XyLlz1h1SR9RvLUa24He/lIAwW4LQB8WrH9Lq4Uo0dfq8N/H1o4b78
         8CE9rwNl026ri5U3VWsranYs8Y4NLOISxJ+B7CEruLHkG7xJhR+fhpzCL2DPfBf5WPN7
         KayYbvSQL940PBze9l1rpxHnTT1c9KLiJOVTt5lREWFcq92XZKm2AEjZppcwumbArPm2
         CVpzYImxKhm4l3fLSEeeEChjgM82m9jDjyCdejAKKBGpTwXx1y8XS04CI9HxhbLFNjQC
         70uPD1CU5ofRV0/PAnrDRRC9n7eDTCNG00h5RIKzWriYQqfXd2SXE+vGDuCg5VlcCuW/
         FSpA==
X-Gm-Message-State: AOAM530fo3E3wp1J9YsQFIwQWDHcmJWjd+adncTAim1CS6HQOP0sHjce
        VDsGwsy/UNrzb7QIj/H4Jxg=
X-Google-Smtp-Source: ABdhPJytD6ptAtpIn588NzjfIpu6I4UO6qCC3Uf3uV9Itz3tNL2JWkYNuAh3R7HQ92ZiU9bz78VqtQ==
X-Received: by 2002:a17:90b:2241:b0:1d2:54b2:64b2 with SMTP id hk1-20020a17090b224100b001d254b264b2mr35898463pjb.225.1650946343519;
        Mon, 25 Apr 2022 21:12:23 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090abd9000b001d2edf4b513sm873683pjr.56.2022.04.25.21.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 21:12:23 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:12:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC bpf-next v4 4/7] btf: Add a new kfunc set which allows to
 mark a function to be sleepable
Message-ID: <20220426041220.xsblwpvmcvceyaco@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-5-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140740.459558-5-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 04:07:37PM +0200, Benjamin Tissoires wrote:
> This allows to declare a kfunc as sleepable and prevents its use in
> a non sleepable program.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

makes sense.
> @@ -17,6 +17,7 @@ enum btf_kfunc_type {
>  	BTF_KFUNC_TYPE_ACQUIRE,
>  	BTF_KFUNC_TYPE_RELEASE,
>  	BTF_KFUNC_TYPE_RET_NULL,
> +	BTF_KFUNC_TYPE_SLEEPABLE,
>  	BTF_KFUNC_TYPE_MAX,
>  };
>  
> @@ -35,6 +36,7 @@ struct btf_kfunc_id_set {
>  			struct btf_id_set *acquire_set;
>  			struct btf_id_set *release_set;
>  			struct btf_id_set *ret_null_set;
> +			struct btf_id_set *sleepable_set;
