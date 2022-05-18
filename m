Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887552BE24
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiEROWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiEROV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 10:21:59 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB494A92D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652883714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIr83Is/azdakrKseNbygkU6wJWyxl8kiVn/QGAmk5I=;
        b=DmK/Zq2fG+kgtL6zA6rfQmRWm5eFEqv3X5eua/utyBb3sNeERuCkrLDktdF/bE4bfh09h8
        /zv8f2Apeu/PPZP/k/+vkDsIBVwQAew58LYSHoGmA+SlajyfwQVGivl/lDZSI+BRIcEbLr
        KPm+2xtdKRli4kRxsCzfVjGhwIIMn9w=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-KTKatfmAPqaeZBYz0UtDQA-1; Wed, 18 May 2022 16:21:53 +0200
X-MC-Unique: KTKatfmAPqaeZBYz0UtDQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuRY2pvjwBoJViIvoBCdH/s96vGB3hTmvpq+SoJdKCOm2sgwcYxyrchWHD6kQfqfBeymHL4f58gwxuUSUw32dr8WFvcls+yMGHZxlEXni1z5qJ2ZeDN/u75MPRFX3yjtePUv03XZTmWdj1TjuNPKndtAfZInIbqR6vG7hqAqn5mqUq7U0Z37E5N9JrhFADRsgrVKW0FARCe2We5EK5g8LnZxvbj5c5hNTP8SgjUE2Zbksal1k8yMwFv0MWnr4hNKseXdVGtjUupzZSEpDiVJtIj6qqKKZcHHOvYvUAfH0DJKgCRkgsAHM2kLXJva7pARx6B7xMF0A+FlHYMn52HJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIr83Is/azdakrKseNbygkU6wJWyxl8kiVn/QGAmk5I=;
 b=T3HVjnCpVbSANkX74lBoRdhHuPuckO5qXSK129kuI0OmGycmz5JsIGC+7p82dC3WYHIuk75YjF68pvWmgtP4W8mC888yC6c1EoxK5kVhWngrX35i/37Pb/WyQl0IHZUjYBVr2RFgHYO+11hVMZYEhDgmr795D353wBg+Ie4h7jA0GMyPng5H35j53RD8kIpK+gTwMzwv5BuVC53GYNAkdNeB/c+is1wXUVltrZzTUey3S6iIiUmeGHRxmomnYy0VVxv59vpkvY1PsDWRlkT1ueglovNYyz5cJyZtPDw71LAi7EY03z1IJeVXDJq9WmJFYHyhHkmFl+lfVVmKty6jVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 14:21:51 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::4dc3:b12b:bd98:b591]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::4dc3:b12b:bd98:b591%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 14:21:51 +0000
Date:   Wed, 18 May 2022 22:21:42 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: refine
 kernel.unpriviliged_bpf_disabled behaviour
Message-ID: <YoUA9k9iowy0meN3@syu-laptop>
References: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
 <1652880861-27373-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652880861-27373-2-git-send-email-alan.maguire@oracle.com>
X-ClientProxiedBy: AS9PR0301CA0026.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::12) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7e25487-7737-4d11-43be-08da38d9bfe2
X-MS-TrafficTypeDiagnostic: AS1PR04MB9405:EE_
X-Microsoft-Antispam-PRVS: <AS1PR04MB9405CD515CEBEEEF17BB187FBFD19@AS1PR04MB9405.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBzFnjdbPgOdK3BsGZXwrV/Co7zXfqNyuqvPUbvjcgL1RT0asJQTUYR2rLertW4ZZQC2+zcY46hzVY/D2g1IYI4ofOztBrCs6xZifNXvKiOezqiAPYr8CDROd4HvxiuIpjqHGixdjg8xgWXoocpddTrWdzqlsOYZ4PCK4u4IVxbkwjOCsPQqrpj+WJU9ntSW8QCkcjBgZAbhW4Mt6f/+ZJVEsBheXXmwMcSNuGXPXnNfzxWChOppcpJiNHB/UfF+DiKUz90sQ4WJtGUmQudfpDihEocZHXKYY7nROiZlPk+rwVM/yYCEVgQxGF0dd4mAEo0zrxkDk1YVmxmaPgQMW+tWCB6bAqFJhBnB+N1g3jMi7zOpKMwtdTU6LEX8rhHxBJ3wjqrgyO0wjFy2tburPH7xIEsxustxY/oXGu1qSlHoPVyggfxDrbjxP0IyhaWHLUKUzhpLEUy+2PXX/amx6tDiznRZZY7r+MOjZnn2SDaRYxPli4U1H9cTuocImTWbbM7mmGowkh49y0hM2JZJ0l0L2uXPXZCrXdHw86XLJvaqXnUDFa6/mKUJPfJUTJeF4Gkm+lEJFOlwpDGpIggg4lgedHsy/wDgv+93AMdADuV9Xym/+bFi/AXQiFk6VRdRHQ2o2p8NwhDDspVBEX9CrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(33716001)(6506007)(5660300002)(6512007)(508600001)(7416002)(8676002)(83380400001)(2906002)(86362001)(66556008)(4326008)(6666004)(38100700002)(66476007)(8936002)(9686003)(186003)(66946007)(6486002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFM1ZWZjS0dEMXc1azU5QmM0eCtNNXFWbVVzWVp0ZW9zN0JialBlRTNoMlRm?=
 =?utf-8?B?QUNDbWJkcUJTTFpSVFV6c3VKOG9JQndEOEpERmdMTTRvOW1aUURyZmVhNGNS?=
 =?utf-8?B?U1NOc2lwZjhLMXVxWG12MG1ZMjJEVXRYSjMvMWpmRkwwTEpDb1BrbFNrU1JM?=
 =?utf-8?B?NkFUVWNIZFV4bTJqRzdZSlZBWWdrR1g1c202OFFnOTBXb1VrNE54N2EvNTF4?=
 =?utf-8?B?SFIxR2F3dlU3dXRoNVlMMzc1ZW55T3VPZW5YbWQ2dWZvb3hib1llUm1VMlB6?=
 =?utf-8?B?TGJqcW5Ma3N4RjB3QjZObTM0OFA1QmJocU4xWlJxREt0ZDkybloxZjFkUnJq?=
 =?utf-8?B?ck1NcWFaOU9LR242TmRUVXY2Q0xHMW56TGZZQ2F3YUZzc0IxTERqTmMxcGV4?=
 =?utf-8?B?NDNXTGdYUEk0a2w2OXBTamN0S1pmTXlKMDVWUmRZL2NvOFVwODUwdWJ2bGFG?=
 =?utf-8?B?WjhnL2Uwa1MxcU84MUJJY0pBcHdmRjEySkplTUIxMkNRK3plVlhQYVMxYzhr?=
 =?utf-8?B?MmZtK3oyY1NmbEsxQVlqSk9OV3BwTllZMkhwWUdVckJFbnhLM3Y5MnQremdC?=
 =?utf-8?B?MjMrVndUR2JrNUNJcTkvK1VuSzRmdTBoV29yWFozY3BoN01TVzFLbzl3enZz?=
 =?utf-8?B?bTFNdTJwdzM2NjlBNGtxakZQUzFtYlRSekE5UDlITmEwdDdCS0V4SW5iV2sv?=
 =?utf-8?B?eEQrUDA2azRqc3FDcElXTFY2ZTcvem1TaTNtRklyTFFZRXZ6ZVJwOFRydkkw?=
 =?utf-8?B?ZTNGcjdTTkFPMGhpQytQdkhKZ25IbEhPVHR6emdyYjNHQkVMNDl2ZG5DK1NT?=
 =?utf-8?B?dVFSYnZncm8zcHRDYUgrLy8yOTY3OTZidCtiZ0pkUHp1RHlEaFpmSmYrVUM0?=
 =?utf-8?B?RDgrVStmNTNzL2NCMElqR25NdzNGQzZmRzdRVDlsdlhaYTJjMnA1UkR6MGJS?=
 =?utf-8?B?OEZhRnhOdzFrNFpmK3RWVW5uV21JTEF5K1NocmZLZC9sUGxYQUk0bEFicUxV?=
 =?utf-8?B?QjQrRnFHMmF0L3o1dW1VUGs3V0Q1WXd5NkgwZzdhOHNRQlJMYzY4cXpCMXkz?=
 =?utf-8?B?bFlkSjdmb1NrVk13N3dkS0swTEhKVjV0dmpvdy83cW5lUkl5bVVxdkk4RHVG?=
 =?utf-8?B?RnBNR0dwRWY5RGpUNTFBWFhnYzdkbmZIcEVXWmhDRWNqSGxrOUpwR0RBZHpo?=
 =?utf-8?B?M0xKT2dmN1h6WE8yeWw5ekQ4TkdVZE1uMUpWUGFYYThUNE9SLzVhMFRLY2kv?=
 =?utf-8?B?dEsrbExZN3RYS3dTSTY3cHcwWFZYL0YxRjd1MkFjUERaejZHamNMbnlodXBO?=
 =?utf-8?B?bysvYklFR1N4NVJNOTIwQVU3ZVZpd1lhQTVwenFETnJDbUVBRnlrRGdLUXFX?=
 =?utf-8?B?TnlVSjV3SkZIQVR4MXVUVTRrOWV6Ulpuaks1bE04aWhRZzlNbzdyQ0Y0N3k5?=
 =?utf-8?B?b3lrcmJOaXRHeEszWk96TlhYNWkrQ2RGOU4vZ0cwUUZjeFFCNWFlY3dsTGY0?=
 =?utf-8?B?MlJESFdvdXMxRnpOcU16dElpNmdrN00zVnVCZzZ1bDlIRUVuWkJUK1gwVWJu?=
 =?utf-8?B?RW45U20yMDF5dGpmbGlIY1hZOGd6SDRIRStYaS9RRzN0VDJVS3RNQUl6WXgy?=
 =?utf-8?B?THcxQ1BLSkJlelJJVzdMZXJyNTBmR3NLN0w1cm8yWW9rK0oySXo5TlFjMHVr?=
 =?utf-8?B?ZDYyTlMwRmRoVDh1UlBTb01EeTUwS0xZMVhpd2l4UDNiWisrdk9la2xsek94?=
 =?utf-8?B?azAwN2htNEdHL0lHdnhaMXhpK3JCU2hNelhOR1ZEZnluUzNaNXpURGE0ODk5?=
 =?utf-8?B?YVZwVXp2Q0F4OUJpRlh6K3BDR1J4SnduTFBwbU5XWUFVU3JSNHlGSnBsWUM4?=
 =?utf-8?B?ejlXWVZtbFBlV2pYcHZBRWpQcXZ2eWRjUXpBeEVWaU5kQ0Jickw5Ni9CNHBS?=
 =?utf-8?B?MlFYTm9mUXh1UWViM2t6cjZRWmtnc3lMT2NidjBvandaVWo2dW5Eak5sL2lu?=
 =?utf-8?B?b2dWbnJ6aGtSYmhXZWp0aXRSVDRmNmdZZ0tyRlZuZ0wvOGZlQ2pDcWQxa3hU?=
 =?utf-8?B?ekpoWWxzZUZXNTZOZFpTaWtEdGY5eDNTU0dORXpVMC9PNzZ3djZLTTFaeW9j?=
 =?utf-8?B?SzBGNEVxaERhcUN2RXU4R1podWVXRUYwbjhyczQ2SGtNMXdPdjhjOVZwK0tk?=
 =?utf-8?B?RElpNGV4KzU1K2RHMUhvcW96Y1kwamR3d0VKdTZmcTVvdUx2LzN3WE9GdC9P?=
 =?utf-8?B?MTF1QlVCN0VjMkNVNmg3ZzVrMGYzd25lUkU3bGZLRE5lVGpaRlA5U3VmR29i?=
 =?utf-8?B?N25xSU9hSWJ6bEhWaUFlL1VrNFV1M09iYzVoQ29OZEJ0TUNEekxQdz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e25487-7737-4d11-43be-08da38d9bfe2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 14:21:51.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30jB6XL5VPtXlv6lhHk6InqXXWh9yq2BCblEZrj7MgLcJLrzH2jSf9Ni5zMpXek+mcv+gApzhosDcrv0lfGdRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 02:34:20PM +0100, Alan Maguire wrote:
> With unprivileged BPF disabled, all cmds associated with the BPF syscall
> are blocked to users without CAP_BPF/CAP_SYS_ADMIN.  However there are
> use cases where we may wish to allow interactions with BPF programs
> without being able to load and attach them.  So for example, a process
> with required capabilities loads/attaches a BPF program, and a process
> with less capabilities interacts with it; retrieving perf/ring buffer
> events, modifying map-specified config etc.  With all BPF syscall
> commands blocked as a result of unprivileged BPF being disabled,
> this mode of interaction becomes impossible for processes without
> CAP_BPF.
> 
> As Alexei notes
> 
> "The bpf ACL model is the same as traditional file's ACL.
> The creds and ACLs are checked at open().  Then during file's write/read
> additional checks might be performed. BPF has such functionality already.
> Different map_creates have capability checks while map_lookup has:
> map_get_sys_perms(map, f) & FMODE_CAN_READ.
> In other words it's enough to gate FD-receiving parts of bpf
> with unprivileged_bpf_disabled sysctl.
> The rest is handled by availability of FD and access to files in bpffs."
> 
> So key fd creation syscall commands BPF_PROG_LOAD and BPF_MAP_CREATE
> are blocked with unprivileged BPF disabled and no CAP_BPF.
> 
> And as Alexei notes, map creation with unprivileged BPF disabled off
> blocks creation of maps aside from array, hash and ringbuf maps.
> 
> Programs responsible for loading and attaching the BPF program
> can still control access to its pinned representation by restricting
> permissions on the pin path, as with normal files.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

