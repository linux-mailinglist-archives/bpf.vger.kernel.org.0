Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4B57BF8E
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 23:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGTV2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGTV2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 17:28:14 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BE599E5
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 14:28:12 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0317B240109
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 23:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658352491; bh=J7A3L5O0aToUp91JxSUtT6ij/Vbhx7lixlGPCzRu7GA=;
        h=Date:From:To:Subject:From;
        b=AG2v+ZXwmI7S44I4ut5FWb5H34c7ssDTNbdM7jsOyvnwW7WfV3qFSboUF7qy/FBRX
         puoIm6mAwdHpW6FICAeDM9sbmZo0cSmU96Y1CSIJn6cAcVv8TVePdP6R8bV5yumziY
         Nu2607i0WvEEMLJA0T4w741tF3WO19tmGm6s5fghmc8kyvJQl2ao9FUR0GmoUm3Tvq
         LOEc/rtl+jSDWOmpOCMlbEOqFcDnAlDCXtIn7k9uRctNzGeVSF/qLEiL3V1QMp8DIU
         tVO4IvoPnLCMWDi2wSlkqq8BpcmqHo0WwzV4u72qMWoyXdGRC0swyX8dBShMI27FT9
         wJPrbvlS3A2nA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lp821196qz6tp1;
        Wed, 20 Jul 2022 23:28:08 +0200 (CEST)
Date:   Wed, 20 Jul 2022 21:28:05 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] samples/bpf: Don't use uninitialized cg2
 variable
Message-ID: <20220720212805.7u626vh52d4kzdch@muellerd-fedora-PC2BDTX9>
References: <20220720205336.3628755-1-deso@posteo.net>
 <20220720210316.g5qygfolwrvq2euq@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720210316.g5qygfolwrvq2euq@muellerd-fedora-PC2BDTX9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 09:03:16PM +0000, Daniel Müller wrote:
> On Wed, Jul 20, 2022 at 08:53:36PM +0000, Daniel Müller wrote:
> > When the setup_cgroup_environment function returns false, we enter a
> > cleanup path that uses the cg2 variable, which, at this point, is not
> > initialized.
> > This change fixes the issue by introducing a new error label that does
> > not perform the close operation which uses said variable on this path.
> > 
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  samples/bpf/test_current_task_under_cgroup_user.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/samples/bpf/test_current_task_under_cgroup_user.c b/samples/bpf/test_current_task_under_cgroup_user.c
> > index ac251a..04a37f 100644
> > --- a/samples/bpf/test_current_task_under_cgroup_user.c
> > +++ b/samples/bpf/test_current_task_under_cgroup_user.c
> > @@ -55,7 +55,7 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	if (setup_cgroup_environment())
> > -		goto err;
> > +		goto err_cgroup;
> >  
> >  	cg2 = create_and_get_cgroup(CGROUP_PATH);
> >  
> > @@ -104,6 +104,7 @@ int main(int argc, char **argv)
> >  
> >  err:
> >  	close(cg2);
> > +err_cgroup:
> >  	cleanup_cgroup_environment();
> >  
> >  cleanup:
> > -- 
> > 2.30.2
> > 
> 
> I see that I may have jumped the gun here. We probably shouldn't be cleaning up
> the cgroup environment when the setup failed. Will update the patch.

...but the semantics of setup_cgroup_environment are actually that it may leave
half initialized state around on failure and cleanup_cgroup_environment is
designed to deal with that. So we are good after all. Sorry for the noise.

Thanks,
Daniel
