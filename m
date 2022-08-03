Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5F588B88
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 13:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiHCLuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiHCLuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 07:50:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C864FD;
        Wed,  3 Aug 2022 04:50:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so10731423edc.1;
        Wed, 03 Aug 2022 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Xfy8aNBxAEIDUkqVJF9Ibo2cxQdqUrKmq9nVT5TGeb4=;
        b=q06uYS6Lpx/evNZGomXqRCnSi8342gUetR1Y0vA5vGVC2K7QTTrg9ovmNnswtOpK9p
         /V4/ZUdZjbfOW2zWJjg7XiQwxU53nb2+eDwpGKlHO7YPCRtD6OFQeTLZmdyVWlwZx0ij
         nUUKDAIt3HmRppJ+39xNtUUtCtprkKWFC46XstVepKe4JiEpPKX4nOjCRS1sU/+MN9PE
         n0UhmANWMeoOA5glqzgucEP4wXMj5F1jkRObnn/JxnP4M/xabXdawTGm4D9clsJs9r6F
         a5js8QGii+4Y/Agw140jFr+0cE7XEVFNCaB1KMTa5WUerLCuh9GQ+8KqNhGIQNX7DiMq
         Y5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Xfy8aNBxAEIDUkqVJF9Ibo2cxQdqUrKmq9nVT5TGeb4=;
        b=ZY2eVBhOAdEu96V9K819UVOG3x89xNW+15ehIqM2ZYo0pmXYHuzbxN0tMW//Lu7V8q
         9p/V14HOZ/TAd2P82nw8aTkH1JRnjiRPgfovichl8XuXFUaYJcNeFu0YAjlyZzlXdD2f
         phjO+ZTtxmV84Lytvo9m5lvqIf68uT32SQNn9TH6Kl6DTWW3/wbApcnjV9hhEAbTkhG4
         6Cd1jJbbwCbP6vqTrvVf4Je21j5a794VZ0jxu7w9q/HoCYzg/OJKxCrUeYEguYjWD8CT
         QWVSvgFdE4hra95a2j2WWxxmMvL8bannhzaJ7Ru/SvFX0Q2D6QsTkVEMnKfbS+IsNu10
         +/9Q==
X-Gm-Message-State: AJIora+m/qiMW2785VxAVViih1R9ZCgPnQWcyIeAmQ5/ys5oUDIvQ/yp
        NZMkRERGJLgJ7YhrYAMSKnY=
X-Google-Smtp-Source: AGRyM1uLxFjncVzokhngRcR7TZtCqTFZL6ndKOsdpRVVFE/OJQ+H7/6eOszl1lH6X3Ddu0EYpF5sDQ==
X-Received: by 2002:a05:6402:ce:b0:43c:874f:e08f with SMTP id i14-20020a05640200ce00b0043c874fe08fmr25805718edu.225.1659527417668;
        Wed, 03 Aug 2022 04:50:17 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906210a00b0072af92fa086sm7197649ejt.32.2022.08.03.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:50:17 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 3 Aug 2022 13:50:15 +0200
To:     Hao Luo <haoluo@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v1] bpf, iter: clean up bpf_seq_read().
Message-ID: <Yupg989wWYl4kmdZ@krava>
References: <20220801205039.2755281-1-haoluo@google.com>
 <YukHHCF0DA6Xb/Rf@krava>
 <CA+khW7iGQyoxRuOR=fHFzjpXLnHKraJ6=brktaZw6Rqkg85a6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iGQyoxRuOR=fHFzjpXLnHKraJ6=brktaZw6Rqkg85a6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 02, 2022 at 05:15:50PM -0700, Hao Luo wrote:
> On Tue, Aug 2, 2022 at 4:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 01, 2022 at 01:50:39PM -0700, Hao Luo wrote:
> >
> > SNIP
> >
> > > +static int do_seq_show(struct seq_file *seq, void *p, size_t offs)
> > > +{
> > > +     int err;
> > > +
> > > +     WARN_ON(IS_ERR_OR_NULL(p));
> > > +
> > > +     err = seq->op->show(seq, p);
> > > +     if (err > 0) {
> > > +             /* object is skipped, decrease seq_num, so next
> > > +              * valid object can reuse the same seq_num.
> > > +              */
> > > +             bpf_iter_dec_seq_num(seq);
> > > +             seq->count = offs;
> > > +             return err;
> > > +     }
> > > +
> > > +     if (err < 0 || seq_has_overflowed(seq)) {
> > > +             seq->count = offs;
> > > +             return err ? err : -E2BIG;
> > > +     }
> > > +
> > > +     /* err == 0 and no overflow */
> > > +     return 0;
> > > +}
> > > +
> > > +/* do_seq_stop, stops at the given object 'p'. 'p' could be an ERR or NULL. If
> > > + * 'p' is an ERR or there was an overflow, reset seq->count to 'offs' and
> > > + * returns error. Returns 0 otherwise.
> > > + */
> > > +static int do_seq_stop(struct seq_file *seq, void *p, size_t offs)
> > > +{
> > > +     if (IS_ERR(p)) {
> > > +             seq->op->stop(seq, NULL);
> > > +             seq->count = offs;
> >
> > should we set seq->count to 0 in case of error?
> >
> 
> Thanks Jiri. To be honest, I don't know. There are two paths that may
> lead to an error "p".
> 
> First, seq->op->start() could return ERR, in that case, '"offs'" is
> zero and we set it to zero already. This is fine.

ah right, offs is zero at that time, looks good then

> 
> The other one, seq->op->next() could return ERR. This is a case where
> bpf_seq_read() fails to handle right now, so I am not sure what to do.

but maybe we don't need to set seq->count in here, like:

	static int do_seq_stop(struct seq_file *seq, void *p, size_t offs)
	{
		if (IS_ERR(p)) {
			seq->op->stop(seq, NULL);
			return PTR_ERR(p);
		}

because it's already set by error path of do_seq_show

> 
> Based on my understanding reading the code, if seq->count isn't
> zeroed, the current read() will not copy data, but the next read()
> will copy data (see the "if (seq->count)" at the beginning of
> bpf_seq_read). If seq->count is zeroed, the data in buffer will be
> discarded. I don't know what is right.

I think we should return the buffer up to the point there's an error,
that's why we set seq->count to previous offs value after failed
show callback

jirka
