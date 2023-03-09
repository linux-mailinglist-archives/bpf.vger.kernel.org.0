Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900A16B191D
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 03:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCICOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 21:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCICOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 21:14:20 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8661529
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 18:14:16 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3291Ko6L030755;
        Wed, 8 Mar 2023 18:14:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ViS+71M+2b53wiD2PAdQC4mLDMvhYPnbpFBGMvsaMDs=;
 b=ATW4mG8oPIN6Fj2xuAu+B2VRqhYMdHnJ+tBJZHG2V/buB4WW8tEjcd9AVPmUO229kxuv
 IxxKHtlj4pFK4ewgbKWuCYjl4Ii6Ylnu17jR9ExLadkMDQ98Bu7fmfVjiUA+BeLfJppm
 6q0heJb9JDw+dGFXSej5t5hR7kRRXKmJedxj66Yc5GBjigEIP4YePy3DYRDBut1xUbeH
 EoWwZxPhDkrWT8y4xH0vdvqXiANnBs2oLylIx4ooVqdNOkdev+zjxT5NJYY3nm9UJIua
 8zgJ9ZH3v68mGANQ0Vdv7OnD2vEj06gMv3UyjAsfRCptItm+BvGM9knWY/y9UfVeeBEK gg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fergker-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 18:14:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X40xAU8mYOMhdl/mTGlLPjQsw0RvjvWMfYSSriz9jPLBf+Om8NdL4R9n5+3X7B6DQv2v+NHBQRqCdtM+joWHqN7iJYL/71joEcijmgxUTbrAxQ5TtZNu45f6gytR0Gq86Zw62qH7fXFVbWECgxU8OovdQii8VeWXjZYuH6fXOQoBlUYKXOsl3gZGm6qTQLuoRyGtVQvlmKzmKb/u4dHwt8dJ4HiEoctqOr2p0nsO41lJn176ZCv8IBLyrePh6eJvBdPW/CB3BIDLLC9BoTvQYTZeoxrrU3jHBJN4OkC0wGxzby45pE7mAfPcOCH/oePNzYP0ZmA94JQPsvt9cEZkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViS+71M+2b53wiD2PAdQC4mLDMvhYPnbpFBGMvsaMDs=;
 b=NMYJhwYD7npc1z86KS2xUcevA7xU7XfeTEA2u4Ob9ex5Ie8vBOSFe3C7cg3Iyao1WXBZQzuovJIJf7oiOMmYlbMzc3MLJl10/EcB9GUEoeC5jOO+EN/R3Eu0axGL3EppA2EIbf9+/H4/LvSDg0FExbw5cnwsxFZu+4qrcb/slAKNw4lk0E7hVaWGYEz6I1YJgihAQBHNI8gnYYi+kVbEHxoPt1MsUrCEw9ACGTK0UG89Sqs2UJC+sOmDKvCyAIIqMhNLMTCCmfpdftn096BlOGAPxOFW1VJd4VyNgoJY9Cfuet40CcAzZoo5lypkWVRpGsIGxjOXKnBTdYHS4Fhajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SA0PR15MB4032.namprd15.prod.outlook.com (2603:10b6:806:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 02:14:00 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::d2e4:5822:2021:8832%8]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 02:14:00 +0000
Message-ID: <9da6a292-eccf-ff82-8ab1-66614d65cba1@meta.com>
Date:   Wed, 8 Mar 2023 21:13:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 bpf-next] bpf: Refactor release_regno searching logic
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
References: <20230309004504.1153898-1-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230309004504.1153898-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:208:32a::16) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SA0PR15MB4032:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef4a776-ea52-41d6-5a57-08db2043f22f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edPE+5HoZHaN/eGbUH506Uvwje2J/c0ru1qtzJbfE7vRcuMoiKfOTvwVBP7ANTcLIbS0loxWJdjdWSLFy4GgPI6EAPi+IcNPpwoF6dhKTT2oS+FFtT5wAo8hBtB2EvPo7s22KV9u4NLGbSDlBT6vcnSw5nrCcQy6gMcKItOr4HGbEg2jyRG83HtMu+9FTrK2mnZ1fdKy0hFeU4CgF6A3c7neJRGZpklubGeeao69rFKzmTliNwgCEM4JuWEBXaF4fziTtsyXaANQq0xndN0bZOI5vkZ1P+vsNNvoR75TcMK9Z/E9lVAX2i64wAk22WZj52c6RuISqluCKRZYiESo/0cNg4QdE/K1wvhCd0svA7hDmrKgqo+zqVEDEdMYt1JcVwzpHMomJXjl30DZSk/cNrQ1YqkNUBUR51PIsmOenhkawUSyH9JnZGyCz+hqNfxj5ORfrjJc4VVtCOiLJmIfYFp/I8ppjp1Qgdws8kLCL4g/Cb9AQDRj9EWcUhfKMOD4tHBIboGtlOq9w305EI+ywPI55dxFsXp/DC2Tja2+NCe1rtMMjGzHuTEge9Ls12NOfY7tET+NNJ4vAWvgS0KxoaNgTekpOQ75746AG2ENDDtgWT0Dle2tnYQ7oXpKYEciICvRmYxA0iWch04M3YWtUGRevRL69PRFP8o+lbkxLJB8GKj87r6k3yXg1OIqK+P1TUI98Zhv5AgB5b7W2+QgJWBxMffJMDC88R/EMHS5g0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(31686004)(54906003)(36756003)(38100700002)(86362001)(31696002)(6512007)(6506007)(53546011)(83380400001)(186003)(2616005)(316002)(5660300002)(478600001)(6486002)(4326008)(41300700001)(8936002)(2906002)(66556008)(66476007)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xSbEttbG5ZbFpJaEQ3WlBrVC9MM3MyamlqUm1TakZWMUd3cDVlaWtINTg0?=
 =?utf-8?B?cGlRNzQyalJDMUFOTVdvdkFvSG5vNWNicTloalp1TFpNZDhrQ2VCTFMyUndM?=
 =?utf-8?B?dEJibTFZVGYweEdDMlFSOHRHOFRyVFlaZDNveDdiVVdjV2dUdGdxQ1NxQ2FV?=
 =?utf-8?B?WGVHRmxLQm9KZURvaUJqQzFiZ3gxTCtzNHBBUlFqT2Q5RzVpNVRqeEdMRU11?=
 =?utf-8?B?Q0RTKzNpZXNpbmRyQ013bEFKZ2xmdjBKczlOVU1ma3Yya0VhM2E1dVJoY0h3?=
 =?utf-8?B?bFlyaGNmQmxLNUV2eXBTTXpkaTJEbW8vVTRjR2RCSHJPRFZTWTdBTUdDYXY5?=
 =?utf-8?B?dDIrT3ZsWDFhYnVDYnk3aER2bXRRVGlhR1MzNXhybmxERjA0R3NtS0xKWGhh?=
 =?utf-8?B?ZHV6ajU5TDY1K3hnRGpSQnZpamNSc3dTOTlHRGVMbHdyMjF3MURUYW9hTkNZ?=
 =?utf-8?B?c3ZWYjlReU1LcldEVlFnZmN5bUo0K2J6REVQQ1BWUytCTUtwMGNLWkx1WnJS?=
 =?utf-8?B?YjlHRU1WMm9vWnB2K0tSNzZTSkZXdXh3M1FMeE9SOXBWbDRPWEJJQm1FZGk3?=
 =?utf-8?B?Z0xVam9SSm14QzBMNXlRY09UM1J1dGRHdFYvTG5Zd1NlM3gxTmxZa1kwZ1ho?=
 =?utf-8?B?b1BBQjZIYWVnNDdrKzV6NDJ4anBsd1ZLYzkvVjM3YmpwRVhIcU4vTlZDVG1X?=
 =?utf-8?B?WTVXd1JQZ1BKU1lraUR4ajRtc0M3Sm5EUnIyTVZmbStqOW9TVDl0R08vT1hU?=
 =?utf-8?B?VU5OdGVMaEZOUWhNS1ovZ0lkS2hZdmppNlN2eFl0TEloSUtROVNpeml6TEN5?=
 =?utf-8?B?eXFIS2diOWhtUVEwa2MzNUdTZTh1R29zQWF2a1BLMGpFRy9ocWRKUTVkOWp4?=
 =?utf-8?B?YWZ3djlZVElVZ0g5N0dNUW1IWW5QTm5icXp3NUhBYURlWDBDdjllNEZMQjd0?=
 =?utf-8?B?ZDdkemZZMHFabzdQSmZEeW84dndFQUJaS3FRZXdRY1MwektJaUlJZFJvWnp1?=
 =?utf-8?B?VkFocUxsc3NrbEdDTnM4aWVWczVyREx2YmgvdWgxUzQ0Wkw1c3Q0SlhPeDU4?=
 =?utf-8?B?WENQc1RlUDdmZTlDanZ3dXlUOGRsZzhPQktlaGhQSDN0Slh1YXdkd1VDUzdO?=
 =?utf-8?B?YjBHMUdkQXgwdHlzUnZBWXQ2MjZKa01Rd3oySXUrUTYvYUsyNWpsVGZ2Ymx6?=
 =?utf-8?B?b040Um9OUHNTNXBsRjJScFlRR0FJcXN1RVczWTlOQ24wN2JrU1R4UXgvNW9P?=
 =?utf-8?B?SjRsMk5uUDh0RTZvdE1SWFEwRzZxeU5qYWZXNi9VdXF3b0ZZQWlmZDRBbU9t?=
 =?utf-8?B?dzN4djZyQTg2cXpDV0FxQVdvOFVXbEFYYWd0ekxkNGs5eXRnWG8wTW9tdUho?=
 =?utf-8?B?Tnl2UVhySVpsN3JURWFTRjBYOEVGQkhCUStySFA0bDEvLy9jR24vN2dKa2ZL?=
 =?utf-8?B?MktwYlZ0VS90bVluY1ZzcmVwQzB0WTRBM3JOODk4bDFZeDJrV3dRRWNIZnE3?=
 =?utf-8?B?cFVlQ2Rwek1ueVBCRll2Mm81MTZLdEd5NG9jajJoK3Zwa09GU1Baa3kyNDM5?=
 =?utf-8?B?OHlTcTgrUEg4ZUdKQjVTd01yazNxL2pjODJmbmZmbzI1cDlabmt2Q2YvZ1pD?=
 =?utf-8?B?RVZycnhWVHNmYlpvZEp5cUx1TWcwRjU2YXVmYVVJR3kxY0NQK01WbFRlTzY1?=
 =?utf-8?B?Ulh4WGZCNWZNWTBNWGFTcDlhSFpIT2hnQUgyMkFlKzFHVUZ2WjUxeWtWOTlu?=
 =?utf-8?B?UXFzalM1T2JyOFlzaVVPK3FRTE5jTWZsTTJyUWoraEFvZWxadk52S3AyU3Zr?=
 =?utf-8?B?Y1hMZWdVODRPZmdMNFJLdXJubGI2TGNlcGpkejJRZFZrc1BZd21MU2xzOWtE?=
 =?utf-8?B?US9hZm0rVU90SzIwaitBd2tXcEduc0Qvajc5ZGs3WFJudzAyZTd6dGdsWkZU?=
 =?utf-8?B?OE5jUHBlRG1TdHZ2SXVUZUdrcmFhSUFTMkVhZDUvZGlnbzhvRnJRTTZOcXBI?=
 =?utf-8?B?VXdaVkVveGFmRkQ5T09aYi9jaEF5aDBXcE8vVDM1K2JvdmkzbTNUWTNSSXN1?=
 =?utf-8?B?VHhRV1VrT2lKd1pFaDBmQWpvcUQwUGRLem02ZUt1eTBYRGhTbXlGbHQrb1M2?=
 =?utf-8?B?RVFHM1JxdDd0YU5XRS9Sc1h5SWJSR2FtYzNTRmNVbkVuNnBmekNtM2RydmR6?=
 =?utf-8?Q?vuw3tLAPju2riP2EEZSBoYE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef4a776-ea52-41d6-5a57-08db2043f22f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 02:14:00.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNHh1pFWxMifdajRH8UdO4HBAnE/kJWFm9Ni6GeIPytuKeO9RyCdCHC6UZUNygsmijnA7+86NmwgN4BmlnQWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4032
X-Proofpoint-ORIG-GUID: xX7sdpVBmp9DcgsFjlxHn_v-oOU8DtnR
X-Proofpoint-GUID: xX7sdpVBmp9DcgsFjlxHn_v-oOU8DtnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/8/23 7:45 PM, Dave Marchevsky wrote:
> Kfuncs marked KF_RELEASE indicate that they release some
> previously-acquired arg. The verifier assumes that such a function will
> only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> be released. Multiple kfunc arg regs have ref_obj_id set is considered
> an invalid state.
> 
> For helpers, OBJ_RELEASE is used to tag a particular arg in the function
> proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> arg that the helper will release. There can only be one such tagged arg.
> When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> also considered an invalid state.
> 
> Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
> that examines each individual arg (check_func_arg for helpers and
> check_kfunc_args inner loop for kfuncs). This patch pulls out this
> searching to occur before individual arg type handling, resulting in a
> cleaner separation of logic and shared logic between kfuncs and helpers.
> 
> Two new helper functions are added:
>   * args_find_ref_obj_id_regno
>     * For helpers and kfuncs. Searches through arg regs to find
>       ref_obj_id reg and returns its regno.
> 
>   * helper_proto_find_release_arg_regno
>     * For helpers only. Searches through fn proto args to find the
>       OBJ_RELEASE arg and returns the corresponding regno.
> 
> The refactoring strives to keep failure logic and error messages
> unchanged. However, because the release arg searching is now done before
> any arg-specific type checking, verifier states that are invalid due to
> both invalid release arg state _and_ some type- or helper-specific
> checking logic might see the release arg-related error message first,
> when previously verification would fail for the other reason.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

Bunch of CI test failures :(. Ignore. 
