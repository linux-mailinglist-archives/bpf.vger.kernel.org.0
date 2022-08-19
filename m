Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5959A58C
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiHSSZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiHSSZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:25:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385AC59D0
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:25:37 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGehha016417;
        Fri, 19 Aug 2022 11:25:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JnD3VHviDXLqtc5MxgYsiw0CphIbE+8HuDMopFS5WDo=;
 b=A2q3WhqrKkEfYJmuiy7L6878urEZmz79zxbk3Wpk5zynfLCgw0aIAK0qVuaFZ13cSbWu
 Owmr754biuv6QkaU2J6i4BNdZvFFHzMXco/xmWv+iA66GQ8lKM30+Dh/k/jTDQKXWfaS
 aH+U4mV84//kWYMpOqRtAThZsu77ZycrCK4= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1d1dwbgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 11:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP05U/GeJSjDixBAP2SldJHL1hXCtg6Bi0IKTGu6Rno4j5Kf+b17Q25hW4uT8CGgjtgyk5ZVZkis3BVJ1FTB9bhTArUfed7C17DrWKCGUJgstJ6jbSxTLsUpeRJN0nMHnqWL5ZkdgMv1hOSP7zUJ1H7jeiQHoCJGc9mzolgbUK1ibsIDDEnrhUFb3aA2o8+qb0HrO+RHsRW71lUjBGzNjNzODu4mqlIgUslbGNX0se6H3uywke6f+v96H4W3YBeyKmAyK8fymM7IJLrDPzWmzdk6NQZJ60Q0fGCQ1FU2RdIynCypWg7UVkBnnjwPXtaY+cc7Mzeiezw4Al68LzMWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnD3VHviDXLqtc5MxgYsiw0CphIbE+8HuDMopFS5WDo=;
 b=d5Bmbp7hDtslIA7/H/wO6/a69QTYYERq0LAnzNPTXCFnaeA2exkjtnsdUwJ7HbEuLTb6ZlhSwrnOPisHySjwslIJqCyPPevJ0B3ngKOJGeiYXx8WRBgaKE5Bit3s44B6o92wAF20uRZS8CYRHf/Yz31WmwDoS45blLD+y8NXIitifw6V0JSOhdcUEF+lC2ULjFt1ZO3CbTrKTpvktvUQl7gAnBLhSVvaK+9setDhWHP0kc8mtDrjfYtIYTwVAK37rHh5hO19SIZCrbc17lbSqWlQL0hKHCoz2uvQhoi3DexZcd25KDWY3qG3ZGLJIKtmYZcXrPS/aZOaYvxg2DxEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB3443.namprd15.prod.outlook.com (2603:10b6:408:a8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 18:25:18 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:25:18 +0000
Date:   Fri, 19 Aug 2022 11:25:16 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3 4/5] bpf: update bpf_{g,s}et_retval
 documentation
Message-ID: <20220819182516.h57hxz2mvg2erfzh@kafai-mbp>
References: <20220818232729.2479330-1-sdf@google.com>
 <20220818232729.2479330-5-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818232729.2479330-5-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a48909a-e27e-4ea8-4dbb-08da82102b01
X-MS-TrafficTypeDiagnostic: BN8PR15MB3443:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGkVyguy84apLPRRT8D4HWgdIiw+HtUw8Tds17OU6dSa7yy+AjFWVXloPu1wZduQdXdwl07xU1HTHmfvp0jLJCYfItKtDUb3yfdPHghjHVEH2vhUClz6E3jC2bphW0DBz5uFP7BpXPochv07ypdOIenDkmC8mNJEVun/3zl6KSkLzL4ruVgqn6mx9IGT8OgOIbCleVKpoheJZSTmhbAZPk7PlpUvpWq+jCXlcuYX42yfBvO1c0b9C+M54z7QCG9VnFzMrq+sI4HWyjCAAcMQeBh/7BffZ/lw0H1eAsltwrQmC24XLNe/GNRsKUrjuV1bkf/yW+qNZVZpfd2hl4sVP0tqwlfYXQBBDjVdP8DNd9n4UDpoA9H11H69UvM7gCJjSSfhayiYy1531CQlE9/6O9ZYyH7gmP/mOG8jNRZN+//LX7zU8qC1RteiZe2l3KOYzBhsePlH00zGMjrb3JQrVVo6Fb6UIqwGxRZlV/vn2JkWD8b9OMOThSBUefq4XCbdcqWJTGGlfui2C3oYlg5G2XUd7M8DfjHOwDYnQowCR3r6htr07LkZWUM/NiB11ShtbVCm3Zr/vTvwyD60RLh8mbRUpq5HRHfeNBXP/DCJbgE8fwGJrv1VOyl8Iuv6Jo8loQqfj0NVnjrWn2uWQcNNtHeGwaW4SFWUsaX8vTfWtCEtrf9ySyOBWu4JdeX6v53RYjZmdRbh2lof8R1MOdcbMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(6916009)(5660300002)(4744005)(7416002)(9686003)(6512007)(66476007)(66556008)(4326008)(1076003)(8676002)(186003)(8936002)(86362001)(38100700002)(66946007)(6506007)(316002)(2906002)(478600001)(52116002)(41300700001)(33716001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PubeDKumCPji76h9KErqJ0UEthzRABf7Zbd+HS8THYEP6kwtFtG4ErPWCBX4?=
 =?us-ascii?Q?MaQMKNjl+lXJKOzPh7zwa6m7KAgfrDTu/zeXfSbQbQcwJanh2xIKEne0dXCj?=
 =?us-ascii?Q?t01AY+y2Jq9LzECe77FNzHhD1LAkBUoYYKMMIeELGJ4VrkhXdsIrqMLRMn36?=
 =?us-ascii?Q?PtYIhRcazVlxPZSr0Ut10fjYek7i4a59yIwWPPnOlidQJJpd1rh0WUlN9A7f?=
 =?us-ascii?Q?24ZUOji3uthraXiiJerQYIAOcdFu/o2VSSmX2V3S4j3dWuMbf/fLfBFvebor?=
 =?us-ascii?Q?XrNzJ+FMkGybV1y8U2ChBMyz+hS17HOW574cWoVSg0TFTVOiOiRdTGCNmiKC?=
 =?us-ascii?Q?HggJuyqGUTzfWBz9a9UxnKh/UGsVginwLSUjJLjCcMHOSlFWaUPvKnnSSzWE?=
 =?us-ascii?Q?5G7A1Gjf4NxDrCNqtnpN1Arycr3Z9V5q0iJrVV8+Wb5LpllgNCv53/aKQ6OV?=
 =?us-ascii?Q?70gBT8CdoSBRahKlHD0BLegvOz2f15tTmIHdhexSKiCkm70uQnS9/Xie5A+I?=
 =?us-ascii?Q?XzvMjLlcjXOAf9QyB22Ms/TyNKsKz4IqK609XgFaLzw3oLtBrnY2tgyB8BEz?=
 =?us-ascii?Q?N6Z8P75Hu4tYwFXzS7eCiA5tsXkUKagwpm+obhYtqIdLG5d1YLOm9Ds3BYyq?=
 =?us-ascii?Q?l8fcl5xOkgrybR6XFB8Ot+A0W3PS60lTglfu1KQ3URezn9kY6KCs7aIAoUbZ?=
 =?us-ascii?Q?OELcu+quaaNyNBg4pgjacUw40SNo/ueGJ+Rqh9vwhEHue8bcyQeen4GcrAQo?=
 =?us-ascii?Q?pApMGtgL/oR3tR18R+cLL0rDvi5lkTyMEsXTcDlWqRREkmrrFctLloEchRX0?=
 =?us-ascii?Q?XmozZeDQnKjd3JBa5oCe+cWcMt84xgObFZevioW+WV4BXrGr3CQ1NEl9M5AW?=
 =?us-ascii?Q?2qHCDYbAjC163nhEE8FGbXwH1fcldiGMZsYB4UtWlOd1HbKAd1VbcCwOju+u?=
 =?us-ascii?Q?86878kygW2ijAetetpF0Qc8XIGt5yWLsJ9M6YAOjiQZQbsi+vyShdjpBxn5R?=
 =?us-ascii?Q?hiT8/FITGe/yWcktdoBYERuIzGInqocXHPBSNCuzjOZr7f0OjanPAb2P1Mc0?=
 =?us-ascii?Q?LV4eHBm8ibobVjwyuCJ5NwrB7MYUozVmHuh4LsdZpZryrEvasVSkLZVO7Ngn?=
 =?us-ascii?Q?QaOBPSbH2G7fRMN0yrl9L6omxusbqqCbEHs9MSl8OyyC6eKHztkL1lqXsD8C?=
 =?us-ascii?Q?MOLGZIkYLfPRoIbbt2R5kSDUsX6J4o4ofu65xmNHL25B1jOMSvU25NBAfkWX?=
 =?us-ascii?Q?BQKrg9Ap0ByneNOJ6XBb8H7C2hjE4+sfugF1RMa76ovHqvEtnu7gzELkWMIW?=
 =?us-ascii?Q?O570cbBq3of/45v95oNwWKQVbciWUIccI2+v3TWPrT2229XZ4XY70oSstsST?=
 =?us-ascii?Q?pMEmLYgLKI6ztqD/9XzU4M4CohAn4B+u8gqTKXe4zNwSB7aRuCR5vk6kYofj?=
 =?us-ascii?Q?A86uvbB6OlOV4JxTIkxUh5aTtoaUz3v3La7sAGXBaJdjECJFLKSgG6LKSxMI?=
 =?us-ascii?Q?2KxcnGSQ9Q9C6KLBLW+rrQPC46UAa178+JCjX7oaoQxmBptwF4Wmnu9CQXhk?=
 =?us-ascii?Q?D2NtxMS4sapPSQJj+Tu2N+IdXFrJ+IHocE9APcNdEhIyazxEKnveOWMJ+Nu1?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a48909a-e27e-4ea8-4dbb-08da82102b01
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:25:18.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73BwlJvgD3MoHQb4ixYi+GNLjuLgvAvevqkEFOI8nrmiUmr6e9GtcNB2oFaFtb60
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3443
X-Proofpoint-ORIG-GUID: Vd41uInHBsw9gs_rL13Fo8iIKyeoRtfO
X-Proofpoint-GUID: Vd41uInHBsw9gs_rL13Fo8iIKyeoRtfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:27:28PM -0700, Stanislav Fomichev wrote:
> * replace 'syscall' with 'upper layers', still mention that it's being
>   exported via syscall errno
> * describe what happens in set_retval(-EPERM) + return 1
> * describe what happens with bind's 'return 3'
Acked-by: Martin KaFai Lau <kafai@fb.com>
