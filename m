Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12C4C3244
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiBXQzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 11:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiBXQzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 11:55:04 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 054CC1BA90C
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 08:54:34 -0800 (PST)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CAF120C3217;
        Thu, 24 Feb 2022 08:54:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CAF120C3217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1645721673;
        bh=cU1/dxx0rwutEHhi5rv7Xl5iiSCpIo0B1mTy9uXYxWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFL0D9SJ+0O8Q8bFMdu72MXsorU9NRNeDmXUOqUKXfr9sYPJwpjMULD58SbfPXKeb
         CS2Xt0GqzAh8TN6zQV+2dcqvcwmTWoYJn7kLfISMEMLvTz/DFEJ83vFXkZCTHGeT+8
         XH7P21PEVpC8Aa6CcxHhyilJ8gJ1UoJyiFcCx060=
Date:   Thu, 24 Feb 2022 08:54:28 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [bug report] user_events: Add minimal support for trace_event
 into ftrace
Message-ID: <20220224165428.GA1664@kbox>
References: <20220224105334.GA2248@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224105334.GA2248@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 24, 2022 at 01:53:34PM +0300, Dan Carpenter wrote:
> Hello Beau Belgrave,
> 
> The patch 7f5a08c79df3: "user_events: Add minimal support for
> trace_event into ftrace" from Jan 18, 2022, leads to the following
> Smatch static checker warning:
> 
> 	kernel/trace/trace_events_user.c:399 user_event_parse_field()
> 	error: uninitialized symbol 'name'.
> 
> kernel/trace/trace_events_user.c
>     314 static int user_event_parse_field(char *field, struct user_event *user,
>     315                                   u32 *offset)
>     316 {
>     317         char *part, *type, *name;
>     318         u32 depth = 0, saved_offset = *offset;
>     319         int len, size = -EINVAL;
>     320         bool is_struct = false;
>     321 
>     322         field = skip_spaces(field);
>     323 
>     324         if (*field == '\0')
>     325                 return 0;
>     326 
>     327         /* Handle types that have a space within */
>     328         len = str_has_prefix(field, "unsigned ");
>     329         if (len)
>     330                 goto skip_next;
>     331 
>     332         len = str_has_prefix(field, "struct ");
>     333         if (len) {
>     334                 is_struct = true;
>     335                 goto skip_next;
>     336         }
>     337 
>     338         len = str_has_prefix(field, "__data_loc unsigned ");
>     339         if (len)
>     340                 goto skip_next;
>     341 
>     342         len = str_has_prefix(field, "__data_loc ");
>     343         if (len)
>     344                 goto skip_next;
>     345 
>     346         len = str_has_prefix(field, "__rel_loc unsigned ");
>     347         if (len)
>     348                 goto skip_next;
>     349 
>     350         len = str_has_prefix(field, "__rel_loc ");
>     351         if (len)
>     352                 goto skip_next;
>     353 
>     354         goto parse;
>     355 skip_next:
>     356         type = field;
>     357         field = strpbrk(field + len, " ");
>     358 
>     359         if (field == NULL)
>     360                 return -EINVAL;
>     361 
>     362         *field++ = '\0';
>     363         depth++;
>     364 parse:
>     365         while ((part = strsep(&field, " ")) != NULL) {
>     366                 switch (depth++) {
>     367                 case FIELD_DEPTH_TYPE:
>     368                         type = part;
>     369                         break;
>     370                 case FIELD_DEPTH_NAME:
>     371                         name = part;
>                                 ^^^^^^^^^^^
> name is only initialized here.  Otherwise uninitialized.
> 
>     372                         break;
>     373                 case FIELD_DEPTH_SIZE:
>     374                         if (!is_struct)
>     375                                 return -EINVAL;
>     376 
>     377                         if (kstrtou32(part, 10, &size))
>     378                                 return -EINVAL;
>     379                         break;
>     380                 default:
>     381                         return -EINVAL;
>     382                 }
>     383         }
>     384 
>     385         if (depth < FIELD_DEPTH_SIZE)
>     386                 return -EINVAL;
>     387 
>     388         if (depth == FIELD_DEPTH_SIZE)
>     389                 size = user_field_size(type);
>     390 
>     391         if (size == 0)
>     392                 return -EINVAL;
>     393 
>     394         if (size < 0)
>     395                 return size;
>     396 
>     397         *offset = saved_offset + size;
>     398 
> --> 399         return user_event_add_field(user, type, name, saved_offset, size,
>     400                                     type[0] != 'u', FILTER_OTHER);
>     401 }
> 
> regards,
> dan carpenter

If name was not set the depth would be less than FIELD_DEPTH_SIZE.
Line 385 should protect against this.

Do you have a repro string that you believe would trigger this?

I can further protect against this by simply setting name to NULL at the
start and adding a check if you believe the case is valid.

Thanks,
-Beau
